# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details
  attr_accessor :color_counter
  filter_parameter_logging :password, :password_confirmation
  helper_method :current_user_session, :current_user

  #defaults methods to CRUD
  def default_creation(model,parameters)
    @object=model.new(parameters)
    
    if @object.save
      render :json => {:success => true}
    else
      render :json => {:errors=>{:reason=>"Error", :msg=>@object.errors}}
    end

  end

  def default_updating(model,id,parameters)
    @object=model.find(id)
    if @object.update_attributes(parameters)
      render :json => {:success => true}
    else
      render :json => {:errors=>{:reason=>"Error"}}
    end
  end

  def default_destroy(model,id)
    @object=model.find(id)
    @object.destroy
    render :json => {:success => true}
  end

  #methods to build the trees used in the application
  def join_nodes_orgs(expanded_id,tree)
    tree.map do |u|
        {:id => 'o'+u.id.to_s,
        :iddb => u.id,
        :text => u.name,
        :iconCls => "orgs",
        :expanded => u.id > expanded_id,
        :leaf => (u.strategies.empty? and u.organizations.empty?),
        :type => "organization",
        :children => join_nodes_orgs(expanded_id,u.organizations).concat(
          u.strategies.map { |i| {
            :id => 's'+i.id.to_s,
            :iddb => i.id,
            :text => i.name,
            :leaf => true,
            :iconCls => "strats",
            :type => "strategy",
            :children => []}}
        )}
    end
  end

  def join_nodes_perspectives(tree)
    tree.map do |u|
      {:id => 'p'+u.id.to_s,
       :iddb => u.id,
       :text => u.name,
       :iconCls => "persp",
       :type => "perspective",
       :leaf => u.objectives.empty?,
       :children=>join_nodes_objs(u.objectives)}
    end
  end

  def join_nodes_objs(tree)
    tree.map do |u|
      {:id => 'o'+u.id.to_s,
      :iddb => u.id,
      :text => u.name,
      :iconCls => "objs",
      :leaf => u.objectives.empty?,
      :type => "objective",
      :children=> join_nodes_objs(u.objectives)}
    end
  end

  def join_nodes_initiatives(tree)
    tree.map do |u|
      {:id => u.id,
       :text => u.name,
       :iconCls => "initiative",
       :leaf => u.initiatives.empty?,
       :children=>join_nodes_initiatives(u.initiatives)}
    end
  end

  def join_nodes_all_measures(tree)
    tree.map do |u|
      {:id => 'p'+u.id.to_s,
       :iddb => u.id,
       :text => u.name,
       :iconCls => "persp",
       :type => "perspective",
       :leaf => u.objectives.empty?,
       :children=>join_nodes_all_objectives(u.objectives)}
    end    
  end

  def join_nodes_all_objectives(tree)
    tree.map do |u|
      {:id => 'o'+u.id.to_s,
      :iddb => u.id,
      :text => u.name,
      :iconCls => "objs",
      :leaf => (u.objectives.empty? && u.measures.empty?),
      :type => "objective",
      :children=> u.objectives.empty? ? join_measures(u.measures) : join_nodes_objs(u.objectives)}
    end    
  end

  def join_measures(tree)
    tree.map do |u|
     {:id => u.id,
      :text => u.name,
      :code => u.code,
      :iconCls => "measure",
      :leaf => true}
    end
  end

  #methods to create the fusion charts xml data
  def fusionchart_xml(array)
    xml="<graph>"
    array.map do |item|
      xml+="<set name='#{item[:name]}' value='#{item[:value]}' color='#{item[:color]}' />"
    end
    xml+="</graph>"
  end
  
  def fusionchart_xml_gantt(hash)
    xml="<graph dateFormat='mm/dd/yyyy'>"
    xml+="<categories>"
    hash[:categories].map do |item|
      xml+="<category start='#{item[:start]}' end='#{item[:end]}' name='#{item[:name]}' />"
    end
    xml+="</categories>"
    xml+="<processes isBold='1' headerText='Tasks'>"
    hash[:processes].map do |item|
      xml+="<process name='#{item[:name]}' id='#{item[:id]}' />"
    end
    xml+="</processes>"
    xml+="<tasks>"
    hash[:tasks].map do |item|
      xml+="<task name='#{item[:name]}' start='#{item[:start]}' end='#{item[:end]}' processId='#{item[:processId]}' />"
    end
    xml+="</tasks>"
    xml+="</graph>"
  end

  def get_fchart_color
    @color_counter=@color_counter ? @color_counter + 1 : 0
    color=["1941A5","AFD8F8","F6BD0F","8BBA00","A66EDD","F984A1",
           "CCCC00","999999","0099CC","FF0000","006F00","0099FF",
           "FF66CC","669966","7C7CB4","FF9933","9900FF","99FFCC",
           "CCCCFF","669900"]
    return color[@color_counter]
  end

  #method to light the measures
  #green: good, yellow: alert, red: bad
  def get_light(measure,default,pvalue)
    value_max={
      "green"=>(pvalue>=measure.excellent),
      "yellow"=>(pvalue>=measure.alert && pvalue<measure.excellent),
      "red"=>(pvalue<measure.alert),
      default=>(pvalue==0)
    }
    value_min={
      "green"=>(pvalue<=measure.excellent),
      "yellow"=>(pvalue<=measure.alert && pvalue>measure.excellent),
      "red"=>(pvalue>measure.alert),
      default=>(pvalue==0)
    }
    if (measure.challenge==Challenge::Increasing)
      value_max.each_pair { |key,value| return key if value==true  }
    elsif (measure.challenge==Challenge::Decreasing)
      value_min.each_pair { |key,value| return key if value==true  }
    end
  end

  private
  
     def require_user
      unless current_user
        store_location
        redirect_to new_user_session_url
        return false
      end
    end

    def store_location
      session[:return_to] = request.request_uri
    end

    def current_user_session
      return @current_user_session if defined?(@current_user_session)
      @current_user_session = UserSession.find
    end

    def current_user
      return @current_user if defined?(@current_user)
      @current_user = current_user_session && current_user_session.user
    end
  
end

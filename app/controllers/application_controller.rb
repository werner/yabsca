# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details
  attr_accessor :color_counter
  filter_parameter_logging :password, :password_confirmation
  helper_method :current_user_session, :current_user

  before_filter :set_locale

  def set_locale 
    ## if params[:locale] is nil then I18n.default_locale will be used
    I18n.locale = params[:locale]
    session[:locale] = params[:locale] unless params[:locale].nil?
  end
  
  def default_url_options(options={})
    logger.debug "default_url_options is passed options: #{options.inspect}\n"
    { :locale => I18n.locale }
  end
  
  #defaults methods to CRUD
  def default_creation(model,parameters,rule_model,conditions)

    if search_permissions(rule_model, conditions, "creating")
      @object=model.new(parameters)
    
      if @object.save
        render :json => {:success => true}
      else
        render :json => {:errors=>{:reason=>"Error", :msg=>@object.errors}}
      end
    else
        render :json => {:errors=>{:reason=>"Permissions", :msg=>"You don't have permissions"}}
    end

  end

  def default_updating(model,id,parameters,rule_model,conditions)

    if search_permissions(rule_model, conditions, "updating")
      @object=model.find(id)
      if @object.update_attributes(parameters)
        render :json => {:success => true}
      else
        render :json => {:errors=>{:reason=>"Error"}}
      end
    else
        render :json => {:errors=>{:reason=>"Permissions", :msg=>"You don't have permissions"}}
    end
  end

  def convert_date(date)
    if session[:locale]=='es'
      f=lambda {|dates| dates[1]+'/'+dates[0]+'/'+dates[2] }
      f.call(date.split('/'))
    else
      date
    end    
  end

  def default_destroy(model,id,rule_model,conditions)
    if search_permissions(rule_model, conditions, "deleting")
      @object=model.find(id)
      @object.destroy
      render :json => {:success => true}
    else
      render :json => {:errors=>{:reason=>"Permissions", :msg=>"You don't have permissions"}}
    end
  end

  def parse_excel(upload)
    spread_sheet=ExcelImport.new
    #code period goal achieved 
    spread_sheet.file=upload
    spread_sheet.get_data
  end

  #methods to build the trees used in the application
  def nodes_selection(node,stop="")
    #it receives a node argument to make a regexp and then a select to a table
    #This is for reload the treeview everytime an user clicks on a node
    return_data=[]
    if node.match(/src:root/)
      data=Organization.find_all_by_organization_id(0)
      return_data=join_nodes_orgs(data)
    elsif node.match(/src:orgs/)
      id=node.sub(/src:orgs/,"").to_i
      data=Organization.find_all_by_organization_id(id)
      if data.empty?
        data=Strategy.find_all_by_organization_id(id)
        return_data=join_nodes_strat(data)
      else
        return_data=join_nodes_orgs(data)
      end
    elsif node.match(/src:strats/)
      id=node.sub(/src:strats/,"").to_i
      data=Perspective.find_all_by_strategy_id(id)
      return_data=join_nodes_perspectives(data)
    elsif node.match(/src:persp/)
      id=node.sub(/src:persp/,"").to_i
      data=Objective.find_all_by_perspective_id(id)
      return_data=join_nodes_objs(data)
    #this is for not showing measures
    elsif node.match(/src:objs/) && stop!=:objs
      id=node.sub(/src:objs/,"").to_i
      data=Objective.find(id).measures
      return_data=join_measures(data)
    end

    return_data
  end

  def join_nodes_orgs(tree)
    tree.map do |u|
        {:id => "src:orgs"+u.id.to_s,
        :iddb => u.id,
        :text => u.name,
        :iconCls => "orgs",
        :type => "organization",
        :leaf => (u.strategies.empty? && u.organizations.empty?)
        }
    end
  end

  def join_nodes_strat(tree)
    tree.map do |u|
        {:id => "src:strats"+u.id.to_s,
        :iddb => u.id,
        :text => u.name,
        :iconCls => "strats",
        :type => "strategy",
        :leaf => u.perspectives.empty?}
    end
  end

  def join_nodes_perspectives(tree)
    tree.map do |u|
      {:id => "src:persp"+u.id.to_s,
       :iddb => u.id,
       :text => u.name,
       :type => "perspective",
       :iconCls => "persp",
       :leaf => u.objectives.empty?}
    end
  end

  def join_nodes_objs(tree)
    tree.map do |u|
      {:id => "src:objs"+u.id.to_s,
      :iddb => u.id,
      :text => u.name,
      :iconCls => "objs",
      :type => "objective",
      :leaf =>(u.objectives.empty? && u.measures.empty?)}
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
      {:id => "src:measure"+u.id.to_s,
        :iddb => u.id,
        :text => u.name,
        :code => u.code,
        :type => "measure",
        :iconCls => "measure",
        :leaf => true}
    end
  end
  
  #methods to create the fusion charts xml data
  def fusionchart_xml_proj(array,measure_name)
    xml="<graph><categories>"
    array.map {|item| xml+="<category name='#{item[:name]}' />" }
    xml+="</categories>"

    xml+="<dataset seriesname='#{measure_name}' showValues='0' >"
    array.map {|item| xml+="<set value='#{item[:value]}' color='#{item[:color]}' />" }
    xml+="</dataset>"

    xml+="<dataset seriesName='#{t(:projection)}' parentYAxis='S' color='F6BD0F' anchorSides='10' anchorBorderColor='F6BD0F'>"

    array.map do |item,previous|      
      xml+="<set value='#{item[:proj_value]}' />"
    end
    xml+="</dataset>"
    xml+="</graph>"
  end

  def fusionchart_xml(array)
    xml="<graph>"
    array.map do |item|
      xml+="<set name='#{item[:name]}' value='#{item[:value]}' color='#{item[:color]}' />" if item[:proj]=="no"
    end
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

  private

  def only_admin
    current_user.roles.find(1)
  rescue
    redirect_to "/presentation"
    return false
  end

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

  def search_permissions(rule_model,conditions,rule)
    @result=false

    return true if current_user.nil?

    #Search to find out if current_user is an admin user
    roles=current_user.roles

    roles_id=roles.collect do |i|
      return true if i.id==1
      i.id
    end

    #Search to find out if current_user has permissions
    if rule_model.nil? && conditions.nil?
      @result=true
    else
      object=rule_model.find_by_role_id(roles_id,
              :conditions=>conditions+" and #{rule}='t' ") unless conditions.nil?
      if object.nil?
        @result=false
      else
        @result=true
      end
    end
    
    @result
  end
end

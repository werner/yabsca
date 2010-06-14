# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details
  attr_accessor :color_counter

  # Scrub sensitive parameters from your log
  # filter_parameter_logging :password

  def default_creation(model,parameters)
    @object=model.new(parameters)
    
    if @object.save
      render :json => {:success => true}
    else
      render :json => {:errors=>{:reason=>"Error"}}
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

  def join_nodes_orgs(tree)
    tree.map do |u|
        {:id => 'o'+u.id.to_s,
        :iddb => u.id,
        :text => u.name,
        :iconCls => "orgs",
        :expanded => @nodes.include?(u.id),
        :leaf => (u.strategies.empty? and u.organizations.empty?),
        :type => "organization",
        :children => join_nodes_orgs(u.organizations).concat(
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
       :children=>join_nodes_objs(u.objectives)
       }
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

  def nodes_expanded(data)
    unless data.nil?
      @nodes.push(data.id)
      nodes_expanded data.organization
    end
  end

  def fusionchart_xml(array)
    xml="<graph>"
    array.map do |item|
      xml+="<set name='#{item[:name]}' value='#{item[:value]}' color='#{item[:color]}' />"
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

  def get_light(alert,excellent,default,value)
    if (value>=excellent)
      "green"
    elsif (value>alert && value<excellent)
      "yellow"
    elsif (value<alert)
      "red"
    else
      default
    end
  rescue
    0
  end
end

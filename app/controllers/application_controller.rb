# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details

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
        {:id => u.id,
        :text => u.name,
        :iconCls => "orgs",
        :expanded => @nodes.include?(u.id),
        :leaf => (u.strategies.empty? and u.organizations.empty?),
        :type => "organization",
        :children => join_nodes_orgs(u.organizations).concat(
          u.strategies.map { |i| {
            :id => i.id,
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
      {:id => u.id,
       :text => u.name,
       :iconCls => "persp",
       :type => "perspective",
       :children=>[u.objectives.map { |i|
            {:id => i.id,
            :name => i.name,
            :children=> []}
          }]
       }
    end
  end

  def nodes_expanded(data)
    unless data.nil?
      @nodes.push(data.id)
      nodes_expanded data.organization
    end
  end

end

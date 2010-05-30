class PresentationController < ApplicationController

  def org_and_strat

    @organizations=Organization.all :order => :id

    @nodes=[]
    unless params[:organization_id].to_i==0
      @organization=Organization.find(params[:organization_id])
      nodes_expanded(@organization)
    end

    @taken=[]
    return_data=[]
    return_data.push({
        :text=>"Organizations",
        :expanded=>true,
        :children=>join_nodes(@organizations)
    })

    return_data[0][:children].delete_if { |i| i.nil? }
    respond_to do |format|
      format.json { render :json => return_data }
    end    
  end

  def join_nodes(tree)
    tree.map do |u|
      unless @taken.include?(u.id)
        @taken.push(u.id)
        child={:id => u.id,
        :text => u.name,
        :expanded => @nodes.include?(u.id),
        :type => u.class==Organization ? "organization" : "strategy",
        :children => join_nodes(get_next_node(u))}
        child[:leaf]=true if (u.class == Organization ? (u.strategies.empty? and u.organizations.empty?) : true)
        child
      end
    end
  end

  def nodes_expanded(data)
    unless data.nil?
      @nodes.push(data.id)
      nodes_expanded data.organization
    end
  end

  def get_next_node(object)
    if object.class==Organization
      object.strategies.empty? ?
        object.organizations : object.strategies
    else
      []
    end
  end
end
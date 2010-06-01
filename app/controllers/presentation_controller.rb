class PresentationController < ApplicationController

  def org_and_strat

    @organizations=Organization.find_all_by_organization_id(0)

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
        :iconCls => "home",
        :type => "organization",
        :children=>join_nodes(@organizations)
    })

    respond_to do |format|
      format.json { render :json => return_data }
    end    
  end

  def join_nodes(tree)
    tree.map do |u|
        {:id => u.id,
        :text => u.name,
        :iconCls => "orgs",
        :expanded => @nodes.include?(u.id),
        :leaf => (u.strategies.empty? and u.organizations.empty?),
        :type => "organization",
        :children => join_nodes(u.organizations).concat(
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
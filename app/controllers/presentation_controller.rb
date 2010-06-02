class PresentationController < ApplicationController

  def org_and_strat

    @organizations=Organization.find_all_by_organization_id(0)

    @nodes=[]
    unless params[:organization_id].to_i==0
      @organization=Organization.find(params[:organization_id])
      nodes_expanded(@organization)
    end

    return_data=[]
    return_data.push({
        :text=>"Organizations",
        :expanded=>true,
        :iconCls => "home",
        :type => "organization",
        :children=>join_nodes_orgs(@organizations)
    })

    respond_to do |format|
      format.json { render :json => return_data }
    end    
  end

<<<<<<< HEAD:app/controllers/presentation_controller.rb
  def persp_and_objs
=======
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
>>>>>>> a149077af53dbb74a6ec7bc5d621ff4addcf23eb:app/controllers/presentation_controller.rb

    @perspectives=Perspective.find_all_by_strategy_id(params[:strategy_id])

    return_data=[]
    return_data.push({
        :text=>"Perspectives",
        :expanded=>true,
        :iconCls=>"home",
        :type=>"perspective",
        :children=>join_nodes_perspectives(@perspectives)
    })

    respond_to do |format|
      format.json { render :json => return_data }
    end

  end

end
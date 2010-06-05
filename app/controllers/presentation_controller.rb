class PresentationController < ApplicationController

  def org_and_strat

    @organizations=Organization.find_all_by_organization_id(0)

    @nodes=[]
    unless params[:organization_id].to_i==0
      @organization=Organization.find(params[:organization_id])
      nodes_expanded(@organization)
    end

    return_data=[]
    return_data=join_nodes_orgs(@organizations)

    respond_to do |format|
      format.json { render :json => return_data }
    end    
  end

  def persp_and_objs

    @perspectives=Perspective.find_all_by_strategy_id(params[:strategy_id])

    return_data=[]
    return_data=join_nodes_perspectives(@perspectives)

    respond_to do |format|
      format.json { render :json => return_data }
    end

  end

end
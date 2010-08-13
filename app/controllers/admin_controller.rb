class AdminController < ApplicationController
  before_filter :require_user, :only_admin

  def roles_privileges
    return_data={}

    @roles={}
    data=[]
    if params[:type]=="organization"
      data=OrganizationRule.find_all_by_organization_id(params[:id])
    elsif params[:type]=="strategy"
      data=StrategyRule.find_all_by_strategy_id(params[:id])
    elsif params[:type]=="perspective"
      data=PerspectiveRule.find_all_by_perspective_id(params[:id])
    elsif params[:type]=="objective"
      data=ObjectiveRule.find_all_by_objective_id(params[:id])
    elsif params[:type]=="measure"
      data=MeasureRule.find_all_by_measure_id(params[:id])
    end
    @roles=data.collect { |i| {
      :id=>i.id,
      :name=>i.role.name
    }}

    return_data[:data]=@roles
    respond_to do |format|
      format.json { render :json => return_data }
    end
  end
  
  def everything

    return_data=nodes_selection(params[:node])

    respond_to do |format|
      format.json { render :json => return_data }
    end    
  end

private

  def nodes_privileges(subsystem,module_id)
    if subsystem==SubSystem::Organization
      data=Organization.find(module_id)
        return_data=everything_join_nodes_orgs(data)
    elsif subsystem==SubSystem::Strategy
      data=Strategy.find(module_id)
        return_data=everything_join_nodes_strat(data)
    elsif subsystem==SubSystem::Perspective
      data=Perspective.find(module_id)
        return_data=everything_join_nodes_perspectives(data)
    elsif subsystem==SubSystem::Objective
      data=Objective.find(module_id)
      return_data=everything_join_nodes_objs(data)
    elsif subsystem==SubSystem::Measure
      data=Measure.find(module_id)
      return_data=everything_join_nodes_measures(data)
    end
    return_data
  end

  def node_type(object)
    ss={SubSystem::Measure=>["measure",lambda { Measure.find(object.module_id).name }],
      SubSystem::Organization => ["orgs",lambda { Organization.find(object.module_id).name }],
      SubSystem::Strategy => ["strats",lambda { Strategy.find(object.module_id).name }],
      SubSystem::Perspective => ["persp",lambda { Perspective.find(object.module_id).name }],
      SubSystem::Objective => ["objs",lambda { Objective.find(object.module_id).name }]}

    result=ss.find { |key,value| key==object.module }
    {:id => "src:"+result[1][0]+object.id.to_s,
     :iddb => object.id,
     :text => result[1][1].call,
     :iconCls => result[1][0],
     :leaf => true}

  end
  
end

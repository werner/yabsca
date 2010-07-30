class AdminController < ApplicationController
  before_filter :require_user

  def roles_privileges
    return_data=[]
    if params[:node].match(/src:root/)
      data=Role.all(:conditions=>"id <> 0")
      return_data=data.collect do |u|
        {:id => "src:roles"+u.id.to_s,
        :iddb => u.id,
        :text => u.name,
        :iconCls => "role"}
      end
    elsif params[:node].match(/src:roles/)
      id=params[:node].sub(/src:roles/,"").to_i

      data=Privilege.find_all_by_role_id(id,:order=>:module)
      return_data=data.collect do |u|
        node_type(u)
      end
    end
    
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
      data=Organization.find(module_id,
        :join => " inner join privileges on organizations.id=module_id ")
        return_data=everything_join_nodes_orgs(data)
    elsif subsystem==SubSystem::Strategy
      data=Strategy.find(module_id,
        :join => " inner join privileges on strategies.id=module_id ")
        return_data=everything_join_nodes_strat(data)
    elsif subsystem==SubSystem::Perspective
      data=Perspective.find(module_id,
        :join => " inner join privileges on perspectives.id=module_id ")
        return_data=everything_join_nodes_perspectives(data)
    elsif subsystem==SubSystem::Objective
      data=Objective.find(module_id,
        :join => " inner join privileges on objectives.id=module_id ")
      return_data=everything_join_nodes_objs(data)
    elsif subsystem==SubSystem::Measure
      data=Measure.find(module_id,
        :join => " inner join privileges on measures.id=module_id ")
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

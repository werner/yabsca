class PrivilegesController < ApplicationController

  def create
    subsystem=0
    if params[:node].match(/src:orgs/)
      id=params[:node].sub(/src:orgs/,"").to_i
      subsystem = SubSystem::Organization
    end

    if params[:node].match(/src:strats/)
      id=params[:node].sub(/src:strats/,"").to_i
      subsystem = SubSystem::Strategy
    end

    if params[:node].match(/src:persp/)
      id=params[:node].sub(/src:persp/,"").to_i
      subsystem = SubSystem::Perspective
    end

    if params[:node].match(/src:objs/)
      id=params[:node].sub(/src:objs/,"").to_i
      subsystem = SubSystem::Objective
    end

    if params[:node].match(/src:measure/)
      id=params[:node].sub(/src:measure/,"").to_i
      subsystem = SubSystem::Measure
    end

    self.default_creation(Privilege, {:module => subsystem,
                             :privilege => Rule::Read, :module_id => id,
                             :role_id=>params[:role_id]})
  end

  def show
    privilege=Privilege.find(params[:id])
    return_data=[]
    return_data[:data]=privilege
    respond_to do |format|
      format.json { render :json => return_data }
    end
  end
end

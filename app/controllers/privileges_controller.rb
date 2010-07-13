class PrivilegesController < ApplicationController

  def create

    (id,subsystem)=choose_node
    self.default_creation(Privilege, {:module => subsystem,
                             :reading => true, :module_id => id,
                             :role_id=>params[:role_id]})
  end
  
  def update
    self.default_updating(Privilege, params[:id], params[:privilege])
  end

  def delete
    self.default_destroy(Privilege, params[:id])
  end
  
  def show
    privilege=Privilege.find(params[:id])
    return_data={}
    return_data[:data]=privilege
    respond_to do |format|
      format.json { render :json => return_data }
    end
  rescue ActiveRecord::RecordNotFound
    
    (id,subsystem)=choose_node

    parameters={}
    parameters[:data]={:privilege=>{:module => subsystem,
                   :reading => true, :module_id => id,
                   :role_id=>params[:role_id]}}

    privilege=Privilege.new(parameters[:data][:privilege])

    privilege.save
    
    respond_to do |format|
      format.json { render :json => parameters }
    end    
  end

  private

  def choose_node
    subsystem=0
    id=0
    if params[:node].match(/src:orgs/)
      id=params[:node].sub(/src:orgs/,"").to_i
      subsystem = SubSystem::Organization
    elsif params[:node].match(/src:strats/)
      id=params[:node].sub(/src:strats/,"").to_i
      subsystem = SubSystem::Strategy
    elsif params[:node].match(/src:persp/)
      id=params[:node].sub(/src:persp/,"").to_i
      subsystem = SubSystem::Perspective
    elsif params[:node].match(/src:objs/)
      id=params[:node].sub(/src:objs/,"").to_i
      subsystem = SubSystem::Objective
    elsif params[:node].match(/src:measure/)
      id=params[:node].sub(/src:measure/,"").to_i
      subsystem = SubSystem::Measure
    end

    [id,subsystem]

  end

end

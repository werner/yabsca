class ObjectivesController < ApplicationController

  def edit
    @objective=Objective.find(params[:id])

    return_data={}
    return_data[:success]=true
    return_data[:data]={"objective[name]" => @objective.name,
                        "objective[perspective_id]" => @objective.perspective_id,
                        "objective[objective_id]" => @objective.objective_id}

    respond_to do |format|
      format.json { render :json => return_data }
    end
  end

  def create
    self.default_creation(Objective, params[:objective],
      PerspectiveRule,"perspective_id="+params[:perspective_id])
  end

  def update
    self.default_updating(Objective, params[:id], params[:objective],
      ObjectiveRule,"objective_id="+params[:objective_id])
  end

  def destroy
    self.default_destroy(Objective, params[:id],
      ObjectiveRule,"objective_id="+params[:objective_id])
  end
  
end

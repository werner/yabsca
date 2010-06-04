class ObjectivesController < ApplicationController

  def new
    @objective=Objective.new
  end

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
    self.default_creation(Objective, params[:objective])
  end

  def update
    self.default_updating(Objective, params[:id], params[:objective])
  end

  def destroy
    self.default_destroy(Objective, params[:id])
  end
end

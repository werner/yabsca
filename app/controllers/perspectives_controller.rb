class PerspectivesController < ApplicationController

  def new
    @perspective=Perspective.new
  end

  def edit
    @perspective=Perspective.find(params[:id])

    return_data={}
    return_data[:success]=true
    return_data[:data]={"perspective[name]" => @perspective.name,
                        "perspective[strategy_id]" => @perspective.strategy_id}
                      
    respond_to do |format|
      format.json { render :json => return_data }
    end
end

  def create
    self.default_creation(Perspective, params[:perspective])
  end

  def update
    self.default_updating(Perspective, params[:id], params[:perspective])
  end

  def destroy
    self.default_destroy(Perspective, params[:id])
  end
end

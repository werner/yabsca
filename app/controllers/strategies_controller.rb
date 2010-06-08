class StrategiesController < ApplicationController

  def edit
    @strategy=Strategy.find(params[:id])

    return_data={}
    return_data[:success]=true
    return_data[:data]={"strategy[name]"=>@strategy.name,
                        "strategy[description]"=>@strategy.description,
                        "strategy[organization_id]"=>@strategy.organization_id}

    respond_to do |format|
      format.json { render :json => return_data }
    end
  end

  def create
    self.default_creation(Strategy, params[:strategy])
  end

  def update
    self.default_updating(Strategy, params[:id], params[:strategy])
  end

  def destroy
    self.default_destroy(Strategy, params[:id])
  end
end

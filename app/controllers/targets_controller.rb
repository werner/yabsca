class TargetsController < ApplicationController
  
  def index
    @targets=Target.find_all_by_measure_id(params[:measure_id])

    return_data={}
    return_data[:data]=@targets.collect {|u| {
        :id => u.id,
        :period => u.period,
        :goal => u.goal,
        :achieved => u.achieved
      }}

    respond_to do |format|
      format.json { render :json => return_data }
    end
  end

  def create
    self.default_creation(Target, params[:target])
  end

  def update
    self.default_updating(Target, params[:id], params[:target])
  end

  def destroy
    self.default_destroy(Target, params[:id])
  end
end

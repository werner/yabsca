class ObjectivesController < StandardController
  def initialize
    @model = Objective
  end

  def gantt
    results = Objective.find(params[:id]).get_gantt

    respond_to do |format|
      format.json {render json: results }
    end
  end
end

class PerspectivesController < StandardController
  def initialize
    @model = Perspective
  end

  def index
    params[:node_id] = params[:node] if params[:node_id].nil?
    perspectives = Perspective.tree params[:node_id]
    objectives = Objective.tree params[:node]
    result = perspectives + objectives

    respond_to do |format|
      format.json { render json: {data: result}}
    end
  end

end

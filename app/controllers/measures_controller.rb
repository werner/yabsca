class MeasuresController < StandardController
  def initialize
    @model = Measure 
  end

  def index
    params[:node_id] = params[:node] if params[:node_id].nil?
    measures = Measure.tree params[:node_id]

    respond_to do |format|
      format.json { render json: { data: measures } }
    end
  end

  def create
    #Here I'm trying to make habtm to works with extjs data comming
    params[:measure][:objective_ids] = [params[:objective_ids]] 
    super
  end
end

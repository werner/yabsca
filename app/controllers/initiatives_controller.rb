class InitiativesController < StandardController
  def initialize
    @model = Initiative
  end

  def index
    params[:node_id] ||= params[:node]
    initiatives = Initiative.tree params[:node_id]

    respond_to do |format|
      format.json { render json: { data: initiatives } }
    end
  end

end

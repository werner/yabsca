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

  def get_periods
    measure = Measure.find(params[:query])

    respond_to do |format|
      format.json { render json: measure.get_periods }
    end
  end

  def create
    #Here I'm trying to make habtm to works with extjs data comming
    params[:measure][:objective_ids] = [params[:objective_ids]] 
    super
  end

  def check_formula
    formula = Measure.check_formula(params[:formula])

    respond_to do |format|
      if formula
        format.json { render json: { success: true, data: formula } }
      else
        format.json { render json: { success: false, data: nil } }
      end
    end
  end

  def measure_charts
    results = Measure.find(params[:id]).generate_chart_data

    respond_to do |format|
      format.json { render json: { success: true, data: results } }
    end
    
  end
end

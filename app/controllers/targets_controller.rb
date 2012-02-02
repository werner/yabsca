class TargetsController < StandardController
  def initialize
    @model = Target 
  end

  def index
    targets = Target.where(:measure_id => params[:measure_id])

    respond_to do |format|
      format.json { render json: { data: targets } }
    end
  end

  def calculates_all
    Target.calculates_all(:measure_id => params[:measure_id])

    respond_to do |format|
      format.json { render json: { success: true } }
    end
  end

end

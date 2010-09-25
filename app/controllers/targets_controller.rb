class TargetsController < ApplicationController
  
  def index
    targets=Target.find_all_by_measure_id(params[:measure_id],:order=>:period_date)

    return_data={}
    return_data[:data]=targets.collect {|u| {
        :id => u.id,
        :period => u.period,
        :goal => u.goal,
        :achieved => u.achieved
      }}

    respond_to do |format|
      format.json { render :json => return_data }
    end
  end

  def save_target
    target=Target.find(:first,:conditions => ["measure_id=? and period=?",
                                              params[:measure_id],params[:period]])
    parser=FormulaParser.new
    p=parser.parse(params[:formula])
    p.period=params[:period]
    if target.update_attributes({:achieved=>eval(p.code_value)})
      render :json => {:success => true}
    else
      render :json => {:success => false}
    end
  end
  
  def create
    self.default_creation(Target, params[:target],
      MeasureRule,"measure_id="+params[:measure_id])
  end

  def update
    self.default_updating(Target, params[:id], params[:target],
      MeasureRule,"measure_id="+params[:measure_id])
  end

  def destroy
    self.default_destroy(Target, params[:id],
      MeasureRule,"measure_id="+params[:measure_id])
  end

end

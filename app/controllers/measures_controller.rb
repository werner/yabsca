class MeasuresController < ApplicationController

  def index
    @measures=Objective.find(params[:objective_id]).measures rescue []

    return_data=[]
    return_data=@measures.collect { |u| {
        :id => u.id,
        :text => u.name,
        :iconCls => get_light(u,"measure",Target.average(u.id)),
        :leaf => true
      }}

    respond_to do |format|
      format.json { render :json => return_data }
    end
  end

  #method to get all data used in the formula field, filtering by the strategy
  def all_measures
    perspectives=Perspective.find_all_by_strategy_id(params[:strategy_id])

    return_data=[]
    return_data=join_nodes_all_measures(perspectives)

    respond_to do |format|
      format.json { render :json => return_data }
    end    
  end

  #get the formula
  def get_formula
    formula=Measure.find(params[:id]).formula || ""

    respond_to do |format|
      format.json { render :json => formula }
    end
  end

  #check the syntax of formula is ok
  def check_formula
    parser=FormulaParser.new
    result=(parser.parse(params[:formula]).nil? ? true : false)

    respond_to do |format|
      format.json { render :json => result }
    end
  end

  #get all the measure targets
  def get_all_targets
    result=Measure.find(params[:id]).targets

    respond_to do |format|
      format.json { render :json => result }
    end
  end
  
  def edit
    @measure=Measure.find(params[:id])

    return_data={}
    return_data[:success]=true
    return_data[:data]={"measure[name]" => @measure.name,
                        "measure[code]" => @measure.code,
                        "measure[description]" => @measure.description,
                        "measure[challenge]" => @measure.challenge,
                        "measure[excellent]" => @measure.excellent,
                        "measure[alert]" => @measure.alert,
                        "measure[frecuency]" => @measure.frecuency,
                        "measure[period_from]" => @measure.period_from,
                        "measure[period_to]" => @measure.period_to,
                        "measure[unit_id]" => @measure.unit_id,
                        "measure[responsible_id]" => @measure.responsible_id,
                        "measure[objective_ids][]" => @measure.objective_ids}

    respond_to do |format|
      format.json { render :json => return_data }
    end
  end

  def create
    self.default_creation(Measure, params[:measure])
  end

  def update
    self.default_updating(Measure, params[:id], params[:measure])
  end

  def destroy
    self.default_destroy(Measure, params[:id])
  end
  
end

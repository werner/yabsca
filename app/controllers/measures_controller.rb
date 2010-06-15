class MeasuresController < ApplicationController

  def index
    @measures=Objective.find(params[:objective_id]).measures rescue []

    return_data=[]
    return_data=@measures.collect { |u| {
        :id => u.id,
        :text => u.name,
        :iconCls => get_light(u.alert,u.excellent,"measure",Target.average(u.id)),
        :leaf => true
      }}

    respond_to do |format|
      format.json { render :json => return_data }
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

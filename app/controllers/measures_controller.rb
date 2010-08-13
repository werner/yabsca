class MeasuresController < ApplicationController

  def index
    roles=current_user.roles
    unless roles.find_all_by_id(0).empty? # Admin Role
      @measures=Objective.find(params[:objective_id]).measures rescue []
    else # Other Roles
      measures_roles=MeasureRule.find_all_by_role_id(roles)
      @measures=measures_roles.collect do |i|
        Measure.find_all_by_id(i.measure_id,
          :joins=>"inner join measures_objectives on measures_objectives.measure_id=measures.id",
          :conditions=>["objective_id=?",params[:objective_id]])
      end.flatten
    end

    return_data=[]
    return_data=@measures.collect do |u|
      avg=Target.average(u.id)
      {:id => u.id,
        :text => u.name+(avg==0 ? "" : " ("+avg.to_s+"%) "),
        :iconCls => get_light(u,"measure",Target.average(u.id)),
        :leaf => true}
    end

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
    self.default_creation(Measure, params[:measure],
        ObjectiveRule,"objective_id="+params[:objective_id])
  end

  def update
    self.default_updating(Measure, params[:id], params[:measure],
      MeasureRule,"measure_id="+params[:measure_id])
  end

  def destroy
    self.default_destroy(Measure, params[:id],
      MeasureRule,"measure_id="+params[:measure_id])
  end

  def pasting
    cut=params[:cut]
    copy=params[:copy]
    link=params[:link]
    measure_id=params[:measure_id]
    objective_id=params[:objective_id]

    measure=Measure.find(measure_id)
    if cut=="true"
      measure.update_attributes({:objective_ids=>[objective_id]})
    elsif copy=="true"
      measure_copy=Measure.new({:code=>measure.code+"_copy",:name=>measure.name,
          :description=>measure.description, :challenge=>measure.challenge,
          :excellent=>measure.excellent,:alert=>measure.alert,:frecuency=>measure.frecuency,
          :period_from=>measure.period_from,:period_to=>measure.period_to,:unit_id=>measure.unit_id,
          :responsible_id=>measure.responsible_id,:formula=>measure.formula,
          :objective_ids=>[objective_id]})
      measure_copy.save!
    elsif link=="true"
      ActiveRecord::Base.connection.execute(
        "insert into measures_objectives(objective_id,measure_id) values (#{objective_id},#{measure_id})")
    end

    respond_to do |format|
      format.json { render :json => {:success => true}}
    end
  end
  
end

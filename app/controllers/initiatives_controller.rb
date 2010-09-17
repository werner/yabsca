class InitiativesController < ApplicationController

  def index
    @initiatives=Objective.find(params[:objective_id]).
      initiatives.all(:conditions=>"initiative_id=0")

    return_data=[]
    return_data=join_nodes_initiatives(@initiatives)

    respond_to do |format|
      format.json { render :json => return_data }
    end
  rescue
    respond_to do |format|
      format.json { render :json => [] }
    end
  end

  def edit
    @initiative=Initiative.find(params[:id])

    return_data={}
    return_data[:success]=true
    return_data[:data]={"initiative[name]" => @initiative.name,
                        "initiative[code]" => @initiative.code,
                        "initiative[completed]" => @initiative.completed,
                        "initiative[beginning]" => @initiative.beginning,
                        "initiative[end]" => @initiative.end,
                        "initiative[objective_id]" => @initiative.objective_id,
                        "initiative[responsible_id]" => @initiative.responsible_id,
                        "initiative[initiative_id]" => @initiative.initiative_id}

    respond_to do |format|
      format.json { render :json => return_data }
    end    
  end
  
  def create
    convert_initiative_dates unless params[:initiative][:beginning].nil?
    self.default_creation(Initiative, params[:initiative],
      ObjectiveRule,"objective_id="+params[:objective_id])
  end

  def update
    convert_initiative_dates unless params[:initiative][:beginning].nil?
    self.default_updating(Initiative, params[:id], params[:initiative],
      ObjectiveRule,"objective_id="+params[:objective_id])
  end

  def destroy
    self.default_destroy(Initiative, params[:id],
      ObjectiveRule,"objective_id="+params[:objective_id])
  end

  def convert_initiative_dates
    params[:initiative][:beginning]=convert_date(params[:initiative][:beginning])
    params[:initiative][:end]=convert_date(params[:initiative][:end])    
  end
end

class PrivilegesController < ApplicationController

  def create

    if params[:type]=="organization"
      save_orgs(params[:id],params[:role_id])
    elsif params[:type]=="strategy"
      save_strats(Strategy.find_all_by_id(params[:id]), params[:role_id])
    elsif params[:type]=="perspective"
      save_persp(Perspective.find_all_by_id(params[:id]),params[:role_id])
    elsif params[:type]=="objective"
      save_objs(Objective.find_all_by_id(params[:id]),params[:role_id])
    elsif params[:type]=="measure"
      save_measures(Measure.find_all_by_id(params[:id]),params[:role_id])
    end

    render :json => {:success => true}
  end

  def update
    model=eval(params[:type].capitalize+"Rule")
    self.default_updating(model, params[:id], {:creating=>params[:creating],
                                               :updating=>params[:updating],
                                               :reading=>params[:reading],
                                               :deleting=>params[:deleting]},nil,nil)
  end

  def destroy
    model=eval(params[:type].capitalize+"Rule")
    self.default_destroy(model, params[:id],nil,nil)
  end
  
  def show
    return_data={}
    if params[:type]=="organization"
      privilege=OrganizationRule.find(params[:id])
    elsif params[:type]=="strategy"
      privilege=StrategyRule.find(params[:id])
    elsif params[:type]=="perspective"
      privilege=PerspectiveRule.find(params[:id])
    elsif params[:type]=="objective"
      privilege=ObjectiveRule.find(params[:id])
    elsif params[:type]=="measure"
      privilege=MeasureRule.find(params[:id])
    end
   return_data[:data]=privilege
    respond_to do |format|
      format.json { render :json => return_data }
    end   
  end

  private

  def choose_node
    subsystem=0
    id=0
    if params[:node].match(/src:strats/)
      id=params[:node].sub(/src:strats/,"").to_i
      subsystem = SubSystem::Strategy
    elsif params[:node].match(/src:persp/)
      id=params[:node].sub(/src:persp/,"").to_i
      subsystem = SubSystem::Perspective
    elsif params[:node].match(/src:objs/)
      id=params[:node].sub(/src:objs/,"").to_i
      subsystem = SubSystem::Objective
    elsif params[:node].match(/src:measure/)
      id=params[:node].sub(/src:measure/,"").to_i
      subsystem = SubSystem::Measure
    end

    [id,subsystem]

  end

  def save_orgs(id,role_id)
    org=OrganizationRule.new({:organization_id=>id,
                          :role_id=>role_id,:reading=>true})
    org.save
    orgs=Organization.all(:conditions=>["organization_id=?",id])
    orgs.each do |o|
      org=OrganizationRule.new({:organization_id=>o.id,
                            :role_id=>role_id,:reading=>true})
      org.save
      save_strats(Strategy.find_all_by_organization_id(o.id), role_id)
    end
  end

  def save_strats(strats,role_id)
    strats.each do |i|
      strat=StrategyRule.new({:strategy_id=>i.id,:role_id=>role_id,:reading=>true})
      strat.save
      save_persp(Perspective.find_all_by_strategy_id(i.id),role_id)
    end
  end

  def save_persp(persps,role_id)
    persps.each do |i|
      persp=PerspectiveRule.new({:perspective_id=>i.id,:role_id=>role_id,:reading=>true})
      persp.save
      save_objs(Objective.find_all_by_perspective_id(i.id),role_id)
    end
  end

  def save_objs(objs,role_id)
    objs.each do |i|
      obj=ObjectiveRule.new({:objective_id=>i.id,:role_id=>role_id,:reading=>true})
      obj.save
      measures=Objective.find(i.id).measures rescue []
      save_measures(measures,role_id)
      objs_inside=Objective.find_all_by_objective_id(i.id)
      objs_inside.each do |o|
        obj_in=ObjectiveRule.new({:objective_id=>o.id,:role_id=>role_id,:reading=>true})
        obj_in.save
        measures=Objective.find(o.id).measures rescue []
        save_measures(measures,role_id)
      end
    end
    
  end

  def save_measures(measures,role_id)
    measures.each do |m|
      measure=MeasureRule.new({:measure_id=>m.id,:role_id=>role_id,:reading=>true})
      measure.save
    end
  end
end

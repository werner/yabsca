class PresentationController < ApplicationController

  def org_and_strat

    @organizations=Organization.find_all_by_organization_id(0)

    @nodes=[]
    unless params[:organization_id].to_i==0
      @organization=Organization.find(params[:organization_id])
      nodes_expanded(@organization)
    end

    return_data=[]
    return_data=join_nodes_orgs(@organizations)

    respond_to do |format|
      format.json { render :json => return_data }
    end    
  end

  def persp_and_objs

    @perspectives=Perspective.find_all_by_strategy_id(params[:strategy_id])

    return_data=[]
    return_data=join_nodes_perspectives(@perspectives)

    respond_to do |format|
      format.json { render :json => return_data }
    end

  end

  def get_targets
    measure=Measure.find(params[:measure_id])

    respond_to do |format|
      format.json { render :json => measure.get_periods }
    end

  end

  def generate_chart

    targets=Target.find_all_by_measure_id(params[:measure_id])

    sort_targets=targets.sort_by { |t| t.to_order }

    return_data=sort_targets.map do |item|
      {
        :name => item.period,
        :value => item.achieved,
        :color => get_fchart_color
      }
    end

    respond_to do |format|
      format.xml {render :xml => fusionchart_xml(return_data)}
    end
  end

  def generate_gantt

    initiatives=Initiative.find_all_by_objective_id(params[:objective_id])

    period=initiatives.first.beginning..initiatives.last.end

    categories=[]
    period.each { |i| categories.push(i.beginning_of_month) }

    categories.uniq!

    return_data={}
    return_data[:categories]=categories.map do |item|
      {
        :start=>item.beginning_of_month,
        :end => item.end_of_month,
        :name => Date::MONTHNAMES[item.month]
      }
    end
    
    return_data[:processes]=initiatives.map do |item|
      {:name => item.name, :id => item.id}
    end

    return_data[:tasks]=initiatives.map do |item|
      {:start => item.beginning, :end => item.end,
       :processId=>item.id, :name => item.name}
    end

    respond_to do |format|
      format.xml {render :xml => fusionchart_xml_gantt(return_data)}
    end
  end
  
end
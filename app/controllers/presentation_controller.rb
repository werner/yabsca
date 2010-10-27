class PresentationController < ApplicationController
  before_filter :require_user
  
  def org_and_strat

    return_data=[]
    if params[:node].match(/src:root/)
      data=Organization.find_all_by_organization_id(0)
      return_data=join_nodes_orgs(data)
    elsif params[:node].match(/src:orgs/)
      id=params[:node].sub(/src:orgs/,"").to_i
      data_orgs=Organization.find_all_by_organization_id(id)

      # I got permissions for strategies not for organizations
      roles=current_user.roles

      unless roles.find_all_by_id(1).empty? # Admin Role
        data=Strategy.find_all_by_organization_id(id)
      else # Other Roles
        strats=StrategyRule.find_all_by_role_id(roles)
        data=strats.collect do |i|
          Strategy.find_all_by_id(i.strategy_id,
            :conditions=>["organization_id=?",id])
        end.flatten
      end
      strats=join_nodes_strat(data)
      orgs=join_nodes_orgs(data_orgs)

      #I've got strategies and organizations
      return_data=strats+orgs
    end
    
    respond_to do |format|
      format.json { render :json => return_data }
    end    
  end

  def persp_and_objs

    return_data=[]
    if params[:node].match(/src:root/)
      roles=current_user.roles
      unless roles.find_all_by_id(1).empty? # Admin Role
        data=Perspective.find_all_by_strategy_id(params[:strategy_id])
      else # Other Roles
        persps=PerspectiveRule.find_all_by_role_id(roles)
        data=persps.collect do |i|
          Perspective.find_all_by_id(i.perspective_id,
            :conditions=>["strategy_id=?",params[:strategy_id]])
        end.flatten
      end
      return_data=join_nodes_perspectives(data)
    elsif params[:node].match(/src:persp/)
      id=params[:node].sub(/src:persp/,"").to_i
      roles=current_user.roles
      unless roles.find_all_by_id(1).empty? # Admin Role
        data=Objective.find_all_by_perspective_id(id)
      else # Other Roles
        objs=ObjectiveRule.find_all_by_role_id(roles)
        data=objs.collect do |i|
          Objective.find_all_by_id(i.objective_id,
            :conditions=>["perspective_id=?",id])
        end.flatten
      end
      return_data=join_nodes_objs(data)
    end

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

    targets=Target.to_charts Date.strptime(params[:date_from],"%m/%d/%Y"),
    						 Date.strptime(params[:date_to],"%m/%d/%Y"),
    						 params[:measure_id]
	
    measure=Measure.find(params[:measure_id])

    general=General.new
    all_periods=general.dates_to_periods(Date.strptime(params[:date_from],"%m/%d/%Y"),
    					Date.strptime(params[:date_to],"%m/%d/%Y"),measure.frecuency)

    y=[]
    return_data=targets.map do |item|
      all_periods.delete_if {|x| x==item.period }
      y.push(item.achieved)
      {
        :name => item.period,
        :value => item.achieved,
        :proj_value=> item.achieved,
        :color => get_fchart_color,
        :proj=>"no"
      }
    end
    
    lr=LinearRegression.new(y)

    idx=return_data.length-1
    return_data+=all_periods.map do |item|
      {
        :name=>item,
        :proj_value=>lr.predict(idx+=1),
        :color => get_fchart_color,
        :proj=>"yes"
      }
    end

    respond_to do |format|
        format.xml {
          render :xml => if params[:proj_options]=='yes'  
                            fusionchart_xml_proj(return_data,measure.name)
                         elsif params[:proj_options]=='no'
                            fusionchart_xml(return_data)
                         end
          }
    end
  end

  def generate_gantt

    initiatives=Initiative.find_all_by_objective_id(params[:objective_id],
        :conditions=>["initiative_id=0"], :order=>:beginning)
    return_data=[]
    initiatives.each do |initiative|
      return_data.push({:id=>initiative.id,
          :name=>initiative.name,:startdate=>initiative.beginning+1,
          :tasks=>initiative.initiatives.collect{|init|
            {:id=>init.id,:name=>init.name,
             :date=>init.beginning+1,:duration=>(init.end-init.beginning).to_i*8+8,
             :completed=>init.completed,
             :tasks=>init.initiatives.collect{|i|
               {
                 :id=>i.id,:name=>i.name,:date=>i.beginning+1,:duration=>(i.end-i.beginning).to_i*8+8,
                 :completed=>i.completed
               }
             }
             }
          }})      
    end

    respond_to do |format|
      format.json {render :json => return_data}
    end
  end

  def upload_file
    parse_excel(params["form-file"])
    respond_to do |format|
      format.html
    end
  end
  
end

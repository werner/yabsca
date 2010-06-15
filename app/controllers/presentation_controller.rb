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

    period=measure.period_from..measure.period_to

    multi_month=lambda { |u,x| u.month%x==0 ? u.month/x : nil }
    
    frecuency=[]
    case measure.frecuency
      when Frecuency::Daily
        period.each { |u| frecuency.push(u) }
      when Frecuency::Weekly
        period.each { |u| frecuency.push(u.strftime("%W")+"-"+u.year.to_s) }
      when Frecuency::Monthly
        period.each { |u| frecuency.push(u.month.to_s+"-"+u.year.to_s) }
      when Frecuency::Bimonthly,Frecuency::Three_monthly,Frecuency::Four_monthly
        period.each do |u|
          frecuency.push(multi_month.call(u,measure.frecuency-1).to_s+"-"+u.year.to_s) unless
                                                multi_month.call(u,measure.frecuency-1).nil?
        end
      when Frecuency::Yearly
        period.each { |u| frecuency.push(u.year) }
    end

    frecuency.uniq!

    return_data={}
    return_data[:data]=frecuency.collect {|u|{
        :name => u
      }}

    respond_to do |format|
      format.json { render :json => return_data }
    end

  end

  def generate_chart

    @targets=Target.find_all_by_measure_id(params[:measure_id])

    sort_targets=@targets.sort_by { |t| t.to_order }

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
    return_data=<<EOF
    <graph dateFormat='mm/dd/yyyy'>
   <categories>
      <category start='02/01/2007 00:00:00' end='03/31/2007 23:59:59' name='Q1' />
      <category start='04/01/2007 00:00:00' end='06/30/2007 23:59:59' name='Q2' />
      <category start='07/01/2007 00:00:00' end='08/31/2007 23:59:59' name='Q3' />
   </categories>
   <categories>
      <category start='02/01/2007 00:00:00' end='02/28/2007 23:59:59' name='Feb' />
      <category start='03/01/2007 00:00:00' end='03/31/2007 23:59:59' name='Mar' />
      <category start='04/01/2007 00:00:00' end='04/30/2007 23:59:59' name='Apr' />
      <category start='05/01/2007 00:00:00' end='05/31/2007 23:59:59' name='May' />
      <category start='06/01/2007 00:00:00' end='06/30/2007 23:59:59' name='Jun' />
      <category start='07/01/2007 00:00:00' end='07/31/2007 23:59:59' name='Jul' />
      <category start='08/01/2007 00:00:00' end='08/31/2007 23:59:59' name='Aug' />
   </categories>
   <processes fontSize='11' isBold='1' align='left' headerText='What to do?' headerFontSize='16' headerVAlign='bottom' headerAlign='right'>
      <process name='Research Phase' id="1" />
      <process name='Identify Customers' id="2" />
      <process name='Survey 50 Customers' id="3" />
      <process name='Interpret Requirements' id="4"/>
      <process name='Study Competition' id="5"/>
      <process name='Production Phase' id="6"/>
      <process name='Documentation of features' id="7"/>
      <process name='Brainstorm concepts' id="8"/>
      <process name='Design &amp; Code' id="9"/>
      <process name='Testing / QA' id="10"/>
      <process name='Documentation of product' id="11"/>
      <process name='Global Release' id="12"/>
   </processes>
   <tasks showname="1">
      <task start='02/04/2007 00:00:00' end='04/06/2007 00:00:00' processId="1"  name='Research' showName='1'/>
      <task start='02/04/2007 00:00:00' end='02/10/2007 00:00:00' processId="2" />
      <task start='02/08/2007 00:00:00' end='02/19/2007 00:00:00' processId="3"/>
      <task start='02/19/2007 00:00:00' end='03/02/2007 00:00:00' processId="4" />
      <task start='02/24/2007 00:00:00' end='03/02/2007 00:00:00' processId="5" />
      <task start='03/02/2007 00:00:00' end='08/27/2007 00:00:00' processId="6"  name='Production' showName='1'/>
      <task start='03/02/2007 00:00:00' end='03/21/2007 00:00:00' processId="7"/>
      <task start='03/21/2007 00:00:00' end='04/06/2007 00:00:00' processId="8"/>
      <task start='04/06/2007 00:00:00' end='07/21/2007 00:00:00' processId="9"/>
      <task start='07/21/2007 00:00:00' end='08/19/2007 00:00:00' processId="10"/>
      <task start='07/28/2007 00:00:00' end='08/24/2007 00:00:00' processId="11"/>
      <task start='08/24/2007 00:00:00' end='08/27/2007 00:00:00' processId="12"/>
   </tasks>
 <trendlines>
    <line start='08/14/2007 00:00:00' displayValue='Today' color='333333' thickness='2'  />
        <line start='05/3/2007 00:00:00' end='05/10/2007 00:00:00' displayValue='Vacation' isTrendZone='1' alpha='20' color='FF5904'/>

 </trendlines>
</graph>
EOF
    respond_to do |format|
      format.xml {render :xml => return_data}
    end
  end
  
end
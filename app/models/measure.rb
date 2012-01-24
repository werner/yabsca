class Measure < ActiveRecord::Base
  has_and_belongs_to_many :objectives
  belongs_to :unit
  belongs_to :responsible
  has_many :targets

  validates_presence_of :name
  validates_uniqueness_of :code

  def self.tree(id_node)
    id = id_node.sub(/src:objs/,"").to_i
    Objective.find(id).measures.collect { |measure|
      node measure
    }
  rescue ActiveRecord::RecordNotFound
    []
  end

  #get all periods based on frecuency
  #if Daily get the number of day
  #if monthly get the number of month of the year
  #if weekly get the number of week of the year
  def get_periods

    all_periods = dates_to_periods

    return_data={}
    #to make extjs combobox works
    fake_id=0
    return_data[:data]=all_periods.collect {|u|{ :id => fake_id+=1, :name => u }}
    return_data
  end

  #transform a range of dates in targets periods  
  def dates_to_periods
    
    period = period_from..period_to

    multi_month = lambda { |u,x| u.month % x == 0 ? u.month/x : nil }

    all_periods=[]
    case frecuency
      when Settings.frecuency.daily
        period.each { |u| all_periods.push(u) }
      when Settings.frecuency.weekly
        period.each { |u| all_periods.push(u.strftime("%W")+"-"+u.year.to_s) }
      when Settings.frecuency.monthly
        period.each { |u| all_periods.push(u.month.to_s+"-"+u.year.to_s) }
      when Settings.frecuency.bimonthly, Settings.frecuency.three_monthly, Settings.frecuency.four_monthly
        period.each do |u|
          all_periods.push(multi_month.call(u,frecuency).to_s+"-"+u.year.to_s) unless
                                                multi_month.call(u,frecuency).nil?
        end
      when Settings.frecuency.yearly
        period.each { |u| all_periods.push(u.year) }
    end

    unless all_periods.empty?    
      all_periods.uniq!
    else
      []
    end
  end

  def avg
    Target.average(:achieved,:conditions=>['measure_id=?',id])
  end

  def goal
    Target.average(:goal,:conditions=>['measure_id=?',id])
  end

  def color
    (avg.nil? ? "measure" : get_light(goal,"measure",avg))
  end

  def child_nodes
    children=[]
    formula.gsub(/<c>[a-zA-Z0-9\-\_\.]*<\/c>/){ |code|
      node=Measure.find_by_code(code.sub(/<c>/,'').sub(/<\/c>/,''))
      unless node.nil?
        children.push(node)
        #children.push({:name=>node.name,:color=>node.color})
      end
    } unless formula.nil?
    children
  end

  #method to light the measures
  #green: good, yellow: alert, red: bad
  def get_light(goal,default,pvalue)
    value_max={
      "green"=>(pvalue>=get_perc_value(goal,excellent)),
      "yellow"=>(pvalue>=get_perc_value(goal,alert) && pvalue<get_perc_value(goal,excellent)),
      "red"=>(pvalue<get_perc_value(goal,alert)),
      default=>(pvalue==0)
    }
    value_min={
      "green"=>(pvalue<=get_perc_value(goal, excellent)),
      "yellow"=>(pvalue<=get_perc_value(goal, alert) && pvalue>get_perc_value(goal,excellent)),
      "red"=>(pvalue>get_perc_value(goal,alert)),
      default=>(pvalue==0)
    }
    if (challenge==Challenge::Increasing)
      value_max.each_pair { |key,value| return key if value==true  }
    elsif (challenge==Challenge::Decreasing)
      value_min.each_pair { |key,value| return key if value==true  }
    end
  end

  def get_perc_value(goal,comp)
    perc=((comp*goal)/100 rescue 0)
    perc+goal
  end

  private 

  def self.node(measure)
    { :id => 'src:measure' + measure.id.to_s,
      :iddb => measure.id,
      :text => measure.name,
      :iconCls => 'measure',
      :type => 'measure',
      :leaf => true 
    }
  end
end

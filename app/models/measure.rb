class Measure < ActiveRecord::Base
  belongs_to :unit
  belongs_to :responsible
  
  has_many :targets
  has_and_belongs_to_many :objectives

  validates_presence_of :name
  validates_uniqueness_of :code

  #get all periods based on frecuency
  #if Daily get the number of day
  #if monthly get the number of month of the year
  #if weekly get the number of week of the year
  def get_periods

    general=General.new
    all_periods=general.dates_to_periods(period_from,period_to,frecuency)

    return_data={}
    #to make extjs combobox works
    fake_id=0
    return_data[:data]=all_periods.collect {|u|{ :id => fake_id+=1, :name => u }}
    return_data
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

end

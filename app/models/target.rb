class Target < ActiveRecord::Base
  belongs_to :measure
  attr_accessor :to_order

  #transform the period in a Date to do ordering
  def to_order
    case measure.frecuency
      when Frecuency::Daily,Frecuency::Yearly
        period
      when Frecuency::Monthly
        puts "01"+"/"+period.split("-")[0]+"/"+period.split("-")[1]
        Date.strptime("01"+"/"+period.split("-")[0]+"/"+period.split("-")[1], "%m/%d/%Y")
      when Frecuency::Weekly
        puts "01"+"/"+period.split("-")[0]+"/"+period.split("-")[1]
        Date.strptime("01"+"/"+(period.split("-")[0].to_i/2).to_s+"/"+period.split("-")[1], "%m/%d/%Y")
      when Frecuency::Bimonthly,Frecuency::Three_monthly,Frecuency::Four_monthly
        Date.strptime("01"+"/"+period.split("-")[0]+"/"+period.split("-")[1], "%m/%d/%Y")
    end
  end

  def self.average(measure_id)
    targets=find_all_by_measure_id(measure_id)

    achieved=targets.sum(&:achieved)
    goal=targets.sum(&:goal)
    size=targets.size
    ((achieved/size)*100)/(goal/size)
  rescue
    0
  end

end

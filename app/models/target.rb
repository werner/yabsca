class Target < ActiveRecord::Base
  belongs_to :measure
  attr_accessor :to_order
  before_save {|record| record.period_date=record.period_to_date }
  
  #transform the period in a Date to do ordering
  def period_to_date
    case measure.frecuency
      when Frecuency::Daily,Frecuency::Yearly
        period
      when Frecuency::Monthly,Frecuency::Bimonthly,Frecuency::Three_monthly,Frecuency::Four_monthly
        Date.strptime(period.split("-")[0]+"/"+"01"+"/"+period.split("-")[1], "%m/%d/%Y")
      when Frecuency::Weekly
        Date.strptime((period.split("-")[0].to_i/2).to_s+"/"+"01"+"/"+period.split("-")[1], "%m/%d/%Y")
    end
  end

end

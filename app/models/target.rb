class Target < ActiveRecord::Base
  belongs_to :measure
  attr_accessor :to_order

  scope :to_charts, lambda {|date_from,date_to,measure_id| {:conditions =>
        ["period_date between ? and ? and measure_id=? and achieved is not null", date_from, date_to, measure_id] }}
  
  after_save {|record| record.period_date=record.period_to_date }
  
  #transform the period in a Date to do ordering
  def period_to_date
    case measure.frecuency
      when Settings.frecuency.daily, Settings.frecuency.yearly
        period
      when Settings.frecuency.monthly, Settings.frecuency.bimonthly, Settings.frecuency.three_monthly, Settings.frecuency.four_monthly
        Date.strptime(period.split("-")[0]+"/"+"01"+"/"+period.split("-")[1], "%m/%d/%Y")
      when Settings.frecuency.weekly
        Date.strptime((period.split("-")[0].to_i/2).to_s+"/"+"01"+"/"+period.split("-")[1], "%m/%d/%Y")
    end
  end
  
end

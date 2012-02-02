class Target < ActiveRecord::Base
  belongs_to :measure
  attr_accessor :to_order

  scope :to_charts, lambda {|date_from,date_to,measure_id| {:conditions =>
        ["period_date between ? and ? and measure_id=? and achieved is not null", date_from, date_to, measure_id] }}
  
  after_validation(:on => :create) do
    self.period_date = period_to_date
    calculate
  end
  
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

  private

  #calculates achieved values from measure formula
  def calculate
    formula = self.measure.formula
    unless formula.blank?
      parser = FormulaParser.new
      p = parser.parse(formula)
      p.measure_id = measure.id
      p.period = period
      self.achieved = eval(p.code_value)
    end
  end
  
end

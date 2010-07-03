class Measure < ActiveRecord::Base
  belongs_to :unit
  belongs_to :responsible
  has_many :targets
  has_and_belongs_to_many :objectives

  validates_presence_of :name

  #get all periods based on frecuency
  #if Daily get the number of day
  #if monthly get the number of month of the year
  #if weekly get the number of week of the year
  def get_periods

    period=period_from..period_to

    multi_month=lambda { |u,x| u.month%x==0 ? u.month/x : nil }

    all_periods=[]
    case frecuency
      when Frecuency::Daily
        period.each { |u| all_periods.push(u) }
      when Frecuency::Weekly
        period.each { |u| all_periods.push(u.strftime("%W")+"-"+u.year.to_s) }
      when Frecuency::Monthly
        period.each { |u| all_periods.push(u.month.to_s+"-"+u.year.to_s) }
      when Frecuency::Bimonthly,Frecuency::Three_monthly,Frecuency::Four_monthly
        period.each do |u|
          all_periods.push(multi_month.call(u,frecuency-1).to_s+"-"+u.year.to_s) unless
                                                multi_month.call(u,frecuency-1).nil?
        end
      when Frecuency::Yearly
        period.each { |u| all_periods.push(u.year) }
    end

    all_periods.uniq!

    return_data={}
    #to make extjs combobox works
    fake_id=0
    return_data[:data]=all_periods.collect {|u|{ :id => fake_id+=1, :name => u }}
    return_data
  end
end

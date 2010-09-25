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
end

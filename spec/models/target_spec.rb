require 'spec_helper'

describe Target do
  before do
    @measure1 = Measure.create!(id: 1, code: "001", name: "testing1", 
                                frecuency: 5, period_from: '2011/01/01', period_to: '2011/12/31' )

    @target1 = Target.create!(goal: 100, achieved: 50, period: "01-2011", measure_id: @measure1.id)
    @target2 = Target.create!(goal: 200, achieved: 80, period: "02-2011", measure_id: @measure1.id)
    @target3 = Target.create!(goal: 350, achieved: 100, period: "03-2011", measure_id: @measure1.id)
    @target4 = Target.create!(goal: 150, achieved: 150, period: "04-2011", measure_id: @measure1.id)
  end

  it "should create targets" do
    Target.count.should be(4)
  end

  it "should convert period to date" do
    @target1.period_to_date.should eq(Date.strptime("01/01/2011", "%m/%d/%Y"))
    @target2.period_to_date.should eq(Date.strptime("02/01/2011", "%m/%d/%Y"))
    @target3.period_to_date.should eq(Date.strptime("03/01/2011", "%m/%d/%Y"))
    @target4.period_to_date.should eq(Date.strptime("04/01/2011", "%m/%d/%Y"))
  end
end

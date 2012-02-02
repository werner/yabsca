require 'spec_helper'

describe Target do
  before do
    @measure1 = Measure.create!(id: 1, code: "001", name: "testing1", 
                                frecuency: 5, period_from: '2011/01/01', period_to: '2011/12/31' )

    @measure_formula = Measure.create!(id: 2, code: "002", name: "testing_formula", 
                                frecuency: 5, period_from: '2011/01/01', period_to: '2011/12/31', 
                                formula: "<c>001</c>+54") 

    @target1 = Target.create!(goal: 100, achieved: 50, period: "01-2011", measure_id: @measure1.id)
    @target2 = Target.create!(goal: 200, achieved: 80, period: "02-2011", measure_id: @measure1.id)
    @target3 = Target.create!(goal: 350, achieved: 100, period: "03-2011", measure_id: @measure1.id)
    @target4 = Target.create!(goal: 150, achieved: 150, period: "04-2011", measure_id: @measure1.id)

    @target5 = Target.create!(goal: 100, period: "01-2011", measure_id: @measure_formula.id)
    @target6 = Target.create!(goal: 200, period: "02-2011", measure_id: @measure_formula.id)
    @target7 = Target.create!(goal: 350, period: "03-2011", measure_id: @measure_formula.id)
    @target8 = Target.create!(goal: 150, period: "04-2011", measure_id: @measure_formula.id)
  end

  it "should create targets" do
    Target.count.should be(8)
  end

  it "should convert period to date" do
    @target1.period_to_date.should eq(Date.strptime("01/01/2011", "%m/%d/%Y"))
    @target2.period_to_date.should eq(Date.strptime("02/01/2011", "%m/%d/%Y"))
    @target3.period_to_date.should eq(Date.strptime("03/01/2011", "%m/%d/%Y"))
    @target4.period_to_date.should eq(Date.strptime("04/01/2011", "%m/%d/%Y"))
  end

  it "should calculate values" do
    @target5.achieved.should eq(104)
    @target6.achieved.should eq(134)
    @target7.achieved.should eq(154)
    @target8.achieved.should eq(204)
  end
end

require 'spec_helper'

describe Measure do
  before do
    @measure1 = Measure.create!(id: 1, code: "001", name: "testing1", 
                                frecuency: 5, period_from: '2011/01/01', period_to: '2011/12/31' )
    @measure2 = Measure.create!(id: 2, code: "002", name: "testing2")
    @measure3 = Measure.create!(id: 3, code: "003", name: "testing3")
    @measure4 = Measure.create!(id: 4, code: "004", name: "testing4")
  end

  it "should return monthly periods" do
    data = { :data=> [ 
      {:id=>1, :name=>"1-2011"}, {:id=>2, :name=>"2-2011"}, {:id=>3, :name=>"3-2011"}, 
      {:id=>4, :name=>"4-2011"}, {:id=>5, :name=>"5-2011"}, {:id=>6, :name=>"6-2011"}, 
      {:id=>7, :name=>"7-2011"}, {:id=>8, :name=>"8-2011"}, {:id=>9, :name=>"9-2011"}, 
      {:id=>10, :name=>"10-2011"}, {:id=>11, :name=>"11-2011"}, {:id=>12, :name=>"12-2011"} ] }

    @measure1.get_periods.should eq(data)
  end

end

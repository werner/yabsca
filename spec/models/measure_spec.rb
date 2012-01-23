require 'spec_helper'

describe Measure do
  before do
    @measure1 = Measure.create!(id: 1, code: "001", name: "testing1")
    @measure2 = Measure.create!(id: 2, code: "002", name: "testing2")
    @measure3 = Measure.create!(id: 3, code: "003", name: "testing3")
    @measure4 = Measure.create!(id: 4, code: "004", name: "testing4")
  end

  #it "should return periods" do
  #  @measure1.get_periods
  #end

end

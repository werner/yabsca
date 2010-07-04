require 'spec_helper'

describe Target do

  it "should do right ordering" do
    Measure.create({:id=>1,:code=>"001",:name=>"new measure",:frecuency=>1})
    52.times do |i|
      Target.create({:goal=>100.00,:achieved=>50.05,
                       :period=>i.to_s+"-2010",:measure_id=>1})
    end
    targets = Target.all
    targets.sort_by { |t| t.to_order }
    Target.average(1)
  end

end

require 'spec_helper'

describe Target do

  it "should do right ordering" do
    Measure.create({:id=>1,:code=>"001",:name=>"new measure",:frecuency=>Frecuency::Daily})
    50.times do |i|
      Target.create({:goal=>100.00,:achieved=>10+i,
                       :period=>i.to_s+"-2010",:measure_id=>1})
    end
    targets = Target.all
    targets.sort_by { |t| t.to_order }
  end

end

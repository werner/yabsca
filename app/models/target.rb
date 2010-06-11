class Target < ActiveRecord::Base
  belongs_to :measure
  attr_accessor :to_order

  #get the first part of period to do ordering
  def to_order
    #period[/[\d]./].to_i
    period.gsub(/-/,"").to_i
  end
  
end

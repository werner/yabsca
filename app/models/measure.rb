class Measure < ActiveRecord::Base
  belongs_to :unit
  belongs_to :objective
end

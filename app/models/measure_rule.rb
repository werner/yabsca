class MeasureRule < ActiveRecord::Base
  belongs_to :measure
  belongs_to :role

  validates_uniqueness_of :role_id, :scope => :measure_id
end

class ObjectiveRule < ActiveRecord::Base
  belongs_to :objective
  belongs_to :role

  validates_uniqueness_of :role_id, :scope => :objective_id
end

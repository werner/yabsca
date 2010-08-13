class PerspectiveRule < ActiveRecord::Base
  belongs_to :perspective
  belongs_to :role

  validates_uniqueness_of :role_id, :scope => :perspective_id
end

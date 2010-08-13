class InitiativeRule < ActiveRecord::Base
  belongs_to :initiative
  belongs_to :role

  validates_uniqueness_of :role_id, :scope => :initiative_id
end

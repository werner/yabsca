class OrganizationRule < ActiveRecord::Base
  belongs_to :organization
  belongs_to :role

  validates_uniqueness_of :role_id, :scope => :organization_id
end

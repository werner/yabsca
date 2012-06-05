class Organization < ActiveRecord::Base
  before_create :set_organization_id

  belongs_to :organization
  has_many :organizations
  has_many :strategies

  validates_presence_of :name

  def set_organization_id
    self.organization_id = 0 if self.organization_id.nil?
  end

  #methods to show in the json result so the tree can consume them
  def self.tree(id_node)
    id = id_node.sub(/src:orgs/,"").to_i
    find_all_by_organization_id(id).collect { |organization|
      node organization
    }
  end

  private

  def self.node(organization)
    { :id => 'src:orgs' + organization.id.to_s, 
      :iddb => organization.id, 
      :text => organization.name, 
      :iconCls => 'orgs', 
      :type => 'organization', 
      :leaf => (organization.organizations.empty? && organization.strategies.empty?) }
  end
  #--------------------------------------------------------------
end

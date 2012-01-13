class Organization < ActiveRecord::Base
  belongs_to :organization
  has_many :organizations

  validates_presence_of :name

  #methods to show in the json result so the tree can consume them

  def self.tree(id_node)
    if id_node.eql? 'root'
      root
    else
      id = id_node.sub(/src:orgs/,"").to_i
      find_all_by_organization_id(id).collect { |organization|
        node organization
      }
    end
  end

  def self.root
    {:nodeType => 'async', :text => 'Organization', :draggable => 'false', :iconCls => 'orgs', :id => 'src:root', :iddb => 0}
  end

  def self.node(organization)
    { :id => 'src:orgs' + organization.id.to_s, 
      :iddb => organization.id, 
      :text => organization.name, 
      :iconCls => 'orgs', 
      :type => 'organization', 
      :leaf => organization.organizations.empty? }
  end

  #--------------------------------------------------------------
end

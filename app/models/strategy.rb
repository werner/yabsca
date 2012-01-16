class Strategy < ActiveRecord::Base
  belongs_to :organization

  validates_presence_of :name

  def self.tree(id_node)
    id = id_node.sub(/src:orgs/,"").to_i
    find_all_by_organization_id(id).collect { |strategy|
      node strategy
    }
  end

  private 

  def self.node(strategy)
    { :id => 'src:strats' + strategy.id.to_s,
      :iddb => strategy.id,
      :text => strategy.name,
      :iconCls => 'strats',
      :type => 'strategy',
      :leaf => true
    }
  end
end

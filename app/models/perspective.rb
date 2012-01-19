class Perspective < ActiveRecord::Base
  belongs_to :strategy
  has_many :objectives

  validates_presence_of :name

  def self.tree(id_node)
    if id_node.match(/src:strats/) or id_node.match(/src:root+\d+/)
      id = id_node.sub(/src:strats/,"").to_i
      id = id_node.sub(/src:root/,"").to_i if id == 0
      where(:strategy_id => id).collect { |perspective|
        node perspective
      }
    else
      []
    end
  end

  private 

  def self.node(perspective)
    { :id => 'src:persp' + perspective.id.to_s,
      :iddb => perspective.id,
      :text => perspective.name,
      :iconCls => 'persp',
      :type => 'perspective',
      :leaf => perspective.objectives.empty?
    }
  end

end

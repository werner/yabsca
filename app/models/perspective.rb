class Perspective < ActiveRecord::Base
  belongs_to :strategy
  has_many :objectives

  validates_presence_of :name

  def self.tree(id_node)
    if id_node.eql? 'root'
      root
    else
      id = id_node.sub(/src:strats/,"").to_i
      find_all_by_strategy_id(id).collect { |perspective|
        node perspective
      }
    end
  end

  private 

  def self.root
    [{:nodeType => 'async', :text => 'Perspectives', :draggable => 'false', :iconCls => 'persp', :id => 'src:root', :iddb => 0}]
  end

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

class Organization < ActiveRecord::Base
  def as_json(options={})
    super(:only => [:id], :methods => [:id_node, :text, :iconCls, :type, :leaf])
  end

  #methods to show in the json result so the tree can consume them
  def id_node
    'src:orgs'+self.id.to_s
  end

  def text
    name
  end

  def iconCls
    'orgs'
  end

  def type
    'organization'
  end

  def leaf
    true
  end
  #--------------------------------------------------------------
end

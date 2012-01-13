require 'spec_helper'

describe Organization do
  describe "right format" do

    it "should output json format to root" do
      tree = {:nodeType => 'async', :text => 'Organization', :draggable => 'false', 
              :iconCls => 'orgs', :id => 'src:root', :iddb => 0} 

      Organization.tree('root').should eq(tree)
    end

    it "should output json format to nodes" do
      org = Organization.create!(id: 1, name: "Test1")
      Organization.create!(id: 2, name: "Test2")
      Organization.create!(id: 3, name: "Test3", organization_id: org.id )

      tree = [{ :id => 'src:orgs1', :iddb => 1, :text => "Test1", 
               :iconCls => 'orgs', :type => 'organization', :leaf => false },
              { :id => 'src:orgs2', :iddb => 2, :text => "Test2", 
               :iconCls => 'orgs', :type => 'organization', :leaf => true }]

      Organization.tree('src:root').should eq(tree)
    end

  end
end

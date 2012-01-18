require 'spec_helper'

describe Organization do

  describe "root" do

    it "should output json format" do
      tree = [{:nodeType => 'async', :text => 'Organization', :draggable => 'false', 
              :iconCls => 'orgs', :id => 'src:root', :iddb => 0}] 

      result = Organization.tree('root') + Strategy.tree('root')
      result.should eq(tree)
    end

  end

  describe "organizations and strategies" do

    before do
       organization = Organization.create!(id: 1, name: "Test1")                         
       Organization.create!(id: 2, name: "Test2")
       Organization.create!(id: 3, name: "Test3", organization_id: organization.id )
       Strategy.create!(id: 1, name: "StratTest1", description: "a description", organization_id: organization.id)
       Strategy.create!(id: 2, name: "StratTest2", description: "another description", organization_id: organization.id)
    end

    it "should output json format to organization nodes" do
      tree = [{ :id => 'src:orgs1', :iddb => 1, :text => "Test1", 
               :iconCls => 'orgs', :type => 'organization', :leaf => false },
              { :id => 'src:orgs2', :iddb => 2, :text => "Test2", 
               :iconCls => 'orgs', :type => 'organization', :leaf => true }]

      result = Organization.tree('src:root') + Strategy.tree('src:root')
      result.should eq(tree)
    end

    it "should output json format to organization and strategies nodes" do
      tree = [{ :id => 'src:orgs3', :iddb => 3, :text => "Test3", 
               :iconCls => 'orgs', :type => 'organization', :leaf => true },
              { :id => 'src:strats1', :iddb => 1, :text => "StratTest1", 
               :iconCls => 'strats', :type => 'strategy', :leaf => true },
              { :id => 'src:strats2', :iddb => 2, :text => "StratTest2",      
               :iconCls => 'strats', :type => 'strategy', :leaf => true }]
     
      result = Organization.tree('src:orgs1') + Strategy.tree('src:orgs1')
      result.should eq(tree)
    end

  end
end

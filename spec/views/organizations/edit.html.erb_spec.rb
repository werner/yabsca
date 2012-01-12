require 'spec_helper'

describe "organizations/edit" do
  before(:each) do
    @organization = assign(:organization, stub_model(Organization,
      :name => "MyString",
      :vision => "MyText",
      :goal => "MyText",
      :description => "MyText",
      :organization_id => 1
    ))
  end

  it "renders the edit organization form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => organizations_path(@organization), :method => "post" do
      assert_select "input#organization_name", :name => "organization[name]"
      assert_select "textarea#organization_vision", :name => "organization[vision]"
      assert_select "textarea#organization_goal", :name => "organization[goal]"
      assert_select "textarea#organization_description", :name => "organization[description]"
      assert_select "input#organization_organization_id", :name => "organization[organization_id]"
    end
  end
end

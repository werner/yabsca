require 'test_helper'

class AdminControllerTest < ActionController::TestCase

  test "everything without user" do
    role_admin = Role.create({:name=>'admin'})
    user_admin = User.create({:login=>'admin',
                          :password=>'12345',:password_confirmation=>'12345',
                          :email=>'admin@admin.com',:role_ids=>[1]})
    get :everything
    assert_response :success 
  end
end

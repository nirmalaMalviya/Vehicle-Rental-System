require 'test_helper'

class MyAdminsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @my_admin = my_admins(:one)
  end

  test "should get index" do
    get my_admins_url
    assert_response :success
  end

  test "should get new" do
    get new_my_admin_url
    assert_response :success
  end

  test "should create my_admin" do
    assert_difference('MyAdmin.count') do
      post my_admins_url, params: { my_admin: { age: @my_admin.age, name: @my_admin.name } }
    end

    assert_redirected_to my_admin_url(MyAdmin.last)
  end

  test "should show my_admin" do
    get my_admin_url(@my_admin)
    assert_response :success
  end

  test "should get edit" do
    get edit_my_admin_url(@my_admin)
    assert_response :success
  end

  test "should update my_admin" do
    patch my_admin_url(@my_admin), params: { my_admin: { age: @my_admin.age, name: @my_admin.name } }
    assert_redirected_to my_admin_url(@my_admin)
  end

  test "should destroy my_admin" do
    assert_difference('MyAdmin.count', -1) do
      delete my_admin_url(@my_admin)
    end

    assert_redirected_to my_admins_url
  end
end

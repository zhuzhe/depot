require 'test_helper'

class DailyReportsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:daily_reports)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create daily_report" do
    assert_difference('DailyReport.count') do
      post :create, :daily_report => { }
    end

    assert_redirected_to daily_report_path(assigns(:daily_report))
  end

  test "should show daily_report" do
    get :show, :id => daily_reports(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => daily_reports(:one).to_param
    assert_response :success
  end

  test "should update daily_report" do
    put :update, :id => daily_reports(:one).to_param, :daily_report => { }
    assert_redirected_to daily_report_path(assigns(:daily_report))
  end

  test "should destroy daily_report" do
    assert_difference('DailyReport.count', -1) do
      delete :destroy, :id => daily_reports(:one).to_param
    end

    assert_redirected_to daily_reports_path
  end
end

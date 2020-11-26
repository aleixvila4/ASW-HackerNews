require 'test_helper'

class ContributionApiControllerTest < ActionDispatch::IntegrationTest
  test "should get title:string" do
    get contribution_api_title:string_url
    assert_response :success
  end

  test "should get author:string" do
    get contribution_api_author:string_url
    assert_response :success
  end

  test "should get url:text" do
    get contribution_api_url:text_url
    assert_response :success
  end

  test "should get text:string" do
    get contribution_api_text:string_url
    assert_response :success
  end

end

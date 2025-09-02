require "test_helper"

class TopControllerTest < ActionDispatch::IntegrationTest
  test "GET / (root) shows top#index" do
    get root_url
    assert_response :success
  end
end

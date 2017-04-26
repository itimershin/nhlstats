require 'test_helper'

class ParserControllerTest < ActionController::TestCase
  test "should get nhl" do
    get :nhl
    assert_response :success
  end

end

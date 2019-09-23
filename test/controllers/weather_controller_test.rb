require 'test_helper'

class WeatherControllerTest < ActionDispatch::IntegrationTest
  test "should get city" do
    get weather_city_url
    assert_response :success
  end

  test "should get glocation" do
    get weather_glocation_url
    assert_response :success
  end

end

require 'test_helper'

class PackagesControllerTest < ActionController::TestCase


   test "should get packages route index" do
     get :index ,  "Accept" => "application/json" 
     assert_response :success # should be able to get this code 200
   end
   
   test "should get packages route next_delivery" do
    get :next_delivery ,  "Accept" => "application/json" 
    assert_response :success
   end

   test "should get packages route delivery_cities" do
    get :delivery_cities ,  "Accept" => "application/json" 
    assert_response :success
   end

end
require 'test_helper'

class ProspectsControllerTest < ActionController::TestCase


   test "should get prospects route index" do
 
     get :index,  "Accept" => "application/json" 
     assert_response :success # should be able to get this code 200
   end
    

end
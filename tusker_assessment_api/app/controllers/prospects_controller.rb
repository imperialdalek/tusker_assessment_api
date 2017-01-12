class ProspectsController < ApplicationController
   before_action :remote_packages , :remote_prospects

    # prospects list can be seen on index url as json
    def index

      request.format = :json
      render json: @remote_prospects 

    end




end
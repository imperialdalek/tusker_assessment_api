class PackagesController < ApplicationController
    before_action :next_package_to_deliver, only: [:next_delivery, :delivery_cities]

    # packages list can be seen on index url as json
    def index
        request.format = :json
        render json: @remote_packages 
    end


    # next item for delivery
    def next_delivery
        request.format = :json
        render json: @next_package_to_deliver
    end


    # list of item for delivery grouped by city
    def delivery_cities

      cities = Array.new
      @delivery_cities = {}

      # loop all next_deliveries
      @next_package_to_deliver.each do | delivery |
          # if city not in array add city to city array
          city = delivery[:delivery_city]
          city_key = city.downcase.tr(" ", "_")

          if cities.exclude? city_key
              # add value to cities array and then add contents for driver to deliver
              cities.push(city_key)
              @delivery_cities[city_key] = {
                :city_name =>  delivery[:delivery_city],
                :deliveries => []
              }             
          end 

          # add it to list for driver to deliver
          @delivery_cities[city_key][:deliveries].push({ 
                                                        :contact => delivery[:contact], 
                                                        :next_delivery_code => delivery[:next_delivery_code],  
                                                        :next_delivery_contents => delivery[:next_delivery_contents]
                                                      }) 
       end

        request.format = :json
        render json: @delivery_cities # cities  # @delivery_cities
    end



 

 # return all prospects with packages to deliver next
    def next_package_to_deliver
      delivered_packages = Array.new

      @remote_prospects.each do | prospect | 

          next_delivery =  find_next_box_to_deliver(prospect['received'])          
          temp_array = {
                         :contact => prospect['contact'] , 
                         :received => prospect['received'], 
                         :delivery_city => prospect['delivery_city'] , 
                         :next_delivery_code => next_delivery['code'] ,
                         :next_delivery_contents => next_delivery['contents']
                        }
          delivered_packages.push(temp_array)
          @next_package_to_deliver = delivered_packages
      end

    end 



    # loop list boxes and check of any part of contents have been sent already
    def find_next_box_to_deliver(delivered_packages)

        next_delivery = Array.new
        
        @remote_packages.each do | delivered |
            delivery_check = 0

            delivered['contents'].each do | c |
              if delivered_packages.include? c
                delivery_check = 1
              else
                # stop when false - output code ( contents )
                next_delivery = {'code'=> delivered['code'] , 'contents' => delivered['contents']}
              end 
            end 

            # if delivery_check is still 0 -  we have not delivered box contents in full or part
            if delivery_check == 0
              return next_delivery
            end  
        end
    end


end
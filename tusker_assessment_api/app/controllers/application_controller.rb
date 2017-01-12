class ApplicationController < ActionController::API
     before_action :remote_packages, :remote_prospects

    # read remote prospect data from URL
    def remote_prospects     
      @data_url = 'http://tuskermarvel.com/prospects.json'
      data_url_params = @data_url + '?username='+CGI.escape('username')+'&password='+CGI.escape('tuskermarvel')
      resp = Net::HTTP.get_response(URI.parse(data_url_params))
      @remote_prospects = JSON.parse(resp.body) 
    end

    # read remote package data from URL
    def remote_packages     
      @data_url =  'http://tuskermarvel.com/packages.json'
      data_url_params = @data_url + '?username='+CGI.escape('username')+'&password='+CGI.escape('tuskermarvel')
      resp = Net::HTTP.get_response(URI.parse(data_url_params))
      @remote_packages = JSON.parse(resp.body) 
    end

end
# Default url mappings are:
# 
# * a controller called Main is mapped on the root of the site: /
# * a controller called Something is mapped on: /something
# 
# If you want to override this, add a line like this inside the class:
#
#  map '/otherurl'
#
# this will force the controller to be mounted on: /otherurl.

require 'net/http'
require 'json'

class MainController < Controller
  
   

  # the index action is called automatically when no other action is specified
  def index
    @title = 'Automation Environment'
  end

  def desktopsync
    ips = ['http://172.29.102.130:9093/healthcheck', 'http://172.29.100.170:9093/healthcheck']
    @environments_info = []

    @details = ['activeMQConnection', 'databaseConnection','repositoryConnection', 'versionCheck']
    ips.each do |ip|
      @environments_info.push get_status(ip)
    end    
  end

  # the string returned at the end of the function is used as the html body
  # if there is no template for the action. if there is a template, the string
  # is silently ignored
  def notemplate
    @title = 'Automation Environment!'
    
    return 'There is no \'notemplate.xhtml\' associated with this action.'
  end

  private
  def get_status(ip)
    uri = URI.parse(ip)
    response = Net::HTTP.get(uri)
    response_json = JSON.parse(response)
    {:ip=> ip, :info=> response_json, :error=>nil}
  rescue Exception => e
    {:ip=> ip, :info=> [], :error=>e}
  end
end

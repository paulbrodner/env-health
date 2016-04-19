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
require 'yaml'

class MainController < Controller

  # the index action is called automatically when no other action is specified
  def index
    @title = 'Automation Environment'
  end

  def desktopsync
    @environments_info = []
    configs = YAML.load_file(File.join(Ramaze.options.roots,'configs.yml'))
    @properties_to_show = configs["properties"]

    configs["environments"].each do |environment|

      environment.each do |name, urls|
       status = []
       urls.first["urls"].each do |t|
         t.each do |k,v|
           status.push ({:name=> k, :url=>v, :response => get_response(v)})
         end
       end
       @environments_info.push({:name=>name, :details => status})
      end
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
  def get_response(url)
    uri = URI.parse(url)
    response = Net::HTTP.get(uri)
    response_json = JSON.parse(response)
    {:value=> response_json, :error=>nil}
  rescue Exception => e
    {:value=> [], :error=>e}
  end
end

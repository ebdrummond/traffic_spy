 require 'traffic_spy/version'
require 'sinatra'

module TrafficSpy

  get '/' do
    "TrafficSpy!"
  end

  get '/sources' do  
    erb :sources 
  end

  post '/sources' do  
    "You have registered '#{params[:message]}' with TrafficSpy!"  
  end

end

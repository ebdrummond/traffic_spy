ENV["TRAFFIC_SPY_ENV"] ||= "test"

require 'sinatra/base'
require 'sequel'
require 'traffic_spy/models/base'
require 'traffic_spy/server'
require "traffic_spy/version"








# DB = Sequel.postgres("traffic_spy")

# curl -i -d 'payload={"url":"http://jumpstartlab.com","requestedAt":"2013-03-16 21:38:28 -0700","respondedIn":37,
#   "referredBy":"http://jumpstartlab.com",
#   "parameters":[],
#   "eventName": "socialLogin",
#   "userAgent":"Mozilla/5.0 (Macintosh: Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17",
#   "resolutionWidth":"1920",
#   "resolutionHeight":"1280",
#   "ip":"63.29.38.211"}'  http://localhost:9393/sources/jumpstartlab/data
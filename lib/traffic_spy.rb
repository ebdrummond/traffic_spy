ENV["TRAFFIC_SPY_ENV"] ||= "test"

require 'sinatra/base'
require 'sequel'
require 'traffic_spy/models/base'
require 'traffic_spy/server'
require "traffic_spy/version"








# DB = Sequel.postgres("traffic_spy")

# curl -i -d 'payload={"url":"http://kyle.com/2","requestedAt":"1997-03-02 03:38:28 -0700","respondedIn":47,
#   "referredBy":"http://kyle.com/blog",
#   "requestType":"GET",
#   "parameters":[],
#   "eventName": "antisocialLogin",
#   "userAgent":"Mozilla/5.0 (Linux: Linux 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Opera/24.0.1309.0 Safari/537.17",
#   "resolutionWidth":"1710",
#   "resolutionHeight":"980",
#   "ip":"12.11.38.211"}'  http://localhost:9393/sources/kyle/data
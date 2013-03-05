ENV["TRAFFIC_SPY_ENV"] ||= "test"

require 'sinatra/base'
require 'sequel'
require 'traffic_spy/models/base'
require 'traffic_spy/server'
require "traffic_spy/version"








# DB = Sequel.postgres("traffic_spy")

# curl -i -d 'payload={"url":"http://kyle.com/thisone","requestedAt":"1923-01-02 03:17:28 -0900","respondedIn":17,
#   "referredBy":"http://jumpstartlab.com/checkout",
#   "requestType":"GET",
#   "parameters":[],
#   "eventName": "",
#   "userAgent":"Mozilla/5.0 (Macintosh: OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17",
#   "resolutionWidth":"1710",
#   "resolutionHeight":"980",
#   "ip":"12.11.38.211"}'  http://localhost:9393/sources/kyle/data

# curl -i -d 'payload={"url":"http://jumpstartlab.com/blog","requestedAt":"2013-01-12 21:38:28 -0700","respondedIn":37,"referredBy":"http://jumpstartlab.com","requestType":"GET","parameters":[],"eventName": "socialLogin","userAgent":"Mozilla/5.0 (Macintosh%3B Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17","resolutionWidth":"1920","resolutionHeight":"1280","ip":"63.29.38.211"}' http://localhost:9393/sources/kyle/data
# curl -i -d 'payload={"url":"http://jumpstartlab.com/blog","requestedAt":"2013-02-16 21:38:28 -0700","respondedIn":37,"referredBy":"http://jumpstartlab.com","requestType":"GET","parameters":[],"eventName": "socialLogin","userAgent":"Mozilla/5.0 (Macintosh%3B Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17","resolutionWidth":"1920","resolutionHeight":"1280","ip":"63.29.38.211"}' http://localhost:9393/sources/jumpstartlabsdsd/da

# curl -i -d 'campaignName=12campaign&eventNames[]=registrationStep1&eventNames[]=registrationStep2&eventNames[]=registrationStep3&eventNames[]=registrationStep4'  http://localhost:9393/sources/kyle/campaigns
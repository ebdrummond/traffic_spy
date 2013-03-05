ENV["TRAFFIC_SPY_ENV"] ||= "test"

require 'sequel'
require 'traffic_spy/models/base'
require 'traffic_spy/server'
require "traffic_spy/version"








# DB = Sequel.postgres("traffic_spy")


# curl -i -d 'payload={"url":"http://jumpstartlab.com","requestedAt":"1927-010-02 23:17:28 -0700","respondedIn":27,
#   "referredBy":"http://jumpstartlab.com/checkout",
#   "requestType":"GET",
#   "parameters":[],
#   "eventName": "oscarbuzz",
#   "userAgent":"Mozilla/5.0 (Macintosh: Linux 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Internet Explorer/24.0.1309.0 Safari/537.17",
#   "resolutionWidth":"1710",
#   "resolutionHeight":"980",
#   "ip":"12.11.38.211"}'  http://localhost:9393/sources/elaine/data

#Figure out PG
#Push to Heroku
#Run spec harness
#hour by hour breakdown correct?
#/ at end of page??
#events from campaign events? not showing up on events page (sourced from payloads)

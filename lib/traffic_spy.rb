require 'sinatra/base'
require 'sequel'
require 'traffic_spy/models/base'
require 'traffic_spy/server'
require "traffic_spy/version"
require 'traffic_spy/models/request_parser'
require 'traffic_spy/models/url'
# require 'traffic_spy/models/referring_url'
# require 'traffic_spy/models/ip_address'
# require 'traffic_spy/models/operating_system'
require 'traffic_spy/models/browser'
require 'traffic_spy/models/resolution'
require 'traffic_spy/models/event'







# DB = Sequel.postgres("traffic_spy")
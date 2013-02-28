require 'sinatra/base'
require 'sequel'
require 'traffic_spy/models/base'
require 'traffic_spy/server'
require "traffic_spy/version"
require 'traffic_spy/models/request_parser'
require 'traffic_spy/models/url'






# DB = Sequel.postgres("traffic_spy")
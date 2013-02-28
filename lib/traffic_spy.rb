require 'csv'
require 'sequel'

DB = Sequel.postgres("traffic_spy_test")

DB.create_table :requests do
  primary_key :id
  foreign_key :account_id
  String :http_request
  String :query_strings
  foreign_key :url_id
  foreign_key :referrer_id
  foreign_key :event_id
  foreign_key :resolution_id
  foreign_key :ip_address_id
  foreign_key :browser_id
  foreign_key :os_id
  DateTime :responded_at
  Integer :hour_of_day
  Integer :responded_in
end

DB.create_table :urls do
  primary_key :id
  String :url
end

DB.create_table :referring_urls do
  primary_key :id
  String :referring_url
end

DB.create_table :browsers do
  primary_key :id
  String :browser
end

DB.create_table :resolutions do
  primary_key :id
  String :resolution
end

DB.create_table :accounts do
  primary_key :id
  String :identifier
  String :root_url
end

DB.create_table :ip_addresses do
  primary_key :id
  String :ip_address
end

DB.create_table :events do
  primary_key :id
  String :event
end

DB.create_table :campaigns do
  primary_key :id
  String :campaign
end

DB.create_table :operating_systems do
  primary_key :id
  String :os
end

DB.create_table :campaign_events do
  primary_key :id
  foreign_key :campaign_id
  foreign_key :event_id
end

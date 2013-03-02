Sequel.migration do
  change do
    create_table :payloads do
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
      foreign_key :operating_systems_id
      DateTime :responded_at
      Integer :hour_of_day
      Integer :responded_in
    end
  end
end

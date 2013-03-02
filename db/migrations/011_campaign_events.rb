Sequel.migration do
  change do
    create_table :campaign_events do
      primary_key :id
      foreign_key :campaign_id
      foreign_key :event_id
    end
  end
end
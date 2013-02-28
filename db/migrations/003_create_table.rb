Sequel.migration do
  change do
    create_table :referring_urls do
      primary_key :id
      String :referring_url
    end
  end
end
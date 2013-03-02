Sequel.migration do
  change do
    create_table :ip_addresses do
      primary_key :id
      String :ip_address
    end
  end
end

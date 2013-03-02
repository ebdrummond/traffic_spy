Sequel.migration do
  change do
    create_table :accounts do
      primary_key :id
      String :identifier
      String :root_url
    end
  end
end
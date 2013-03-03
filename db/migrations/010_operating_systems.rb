Sequel.migration do
  change do
    create_table :operating_systems do
      primary_key :id
      String :operating_system
    end
  end
end
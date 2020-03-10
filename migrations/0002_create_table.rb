# frozen_string_literal: true

Sequel.migration do
  change do
    create_table(:cities) do
      primary_key :id
      String :city_name, null: false, size: 100
    end
  end
end

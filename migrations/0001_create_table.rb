# frozen_string_literal: true

Sequel.migration do
  change do
    create_table(:schedules) do
      primary_key :id
      Integer :number, null: false, size: 20
      String :departure_city, null: false, size: 100
      String :arrival_city, null: false, size: 100
      String :departure_time, null: false, size: 100
      String :arrival_time, null: false, size: 100
      Integer :price, null: false, size: 20
    end
  end
end

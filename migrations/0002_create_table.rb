# frozen_string_literal: true

Sequel.migration do
  change do
    create_table(:numbers) do
      primary_key :id
      Integer :number, null: false, size: 20
    end
  end
end

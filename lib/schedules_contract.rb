# frozen_string_literal: true

require 'dry-validation'
# checks data input
class SchedulesContract < Dry::Validation::Contract
  params do
    required(:select_number).value(:integer)
    required(:select_departure_city).value(:string)
    required(:select_arrival_city).value(:string)
    required(:select_price).value(:integer)
  end
  rule(:select_departure_city) do
    key.failure('Length is not correct') if value.length > 50 || value.length < 2 || value.scan(/\D/).empty?
  end
  rule(:select_arrival_city) do
    key.failure('Length is not correct') if value.length > 50 || value.length < 2 || value.scan(/\D/).empty?
  end
  rule(:select_price) do
    key.failure('Price\'s is too much') if value > 15_000
  end
end

# frozen_string_literal: true

require 'sequel'
# model for a schedules datatable
class Number < Sequel::Model(:numbers)
  one_to_many :schedules
end

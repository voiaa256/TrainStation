# frozen_string_literal: true

require 'sequel'
# model for a schedules datatable
class City < Sequel::Model(:cities)
  one_to_many :schedules
end

# frozen_string_literal: true

require 'sequel'
require_relative 'schedule'
# model for a schedules datatable
class Schedule < Sequel::Model(:schedules)
  many_to_one :cities

  def self.search_by(search, selection)
    case selection
    when 'City'
      where(city_id: City.where(Sequel[:city_name].like("#{search}%")).get(:id))
    end
  end
end

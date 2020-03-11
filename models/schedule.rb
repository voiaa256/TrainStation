# frozen_string_literal: true

require 'sequel'
require_relative 'schedule'
# model for a schedules datatable
class Schedule < Sequel::Model(:schedules)
  many_to_one :number

  def self.search_by(search, selection)
    case selection
    when 'Number'
      where(number_id: Number.where(Sequel[:number].like("#{search}%")).get(:id))
    end
  end

  def self.update_schedule(new_number_id, item, schedule_id)
    self[schedule_id].update(number_id: new_number_id,
                             departure_city: item[:select_departure_city],
                             arrival_city: item[:select_arrival_city],
                             departure_time: item[:select_departure_time],
                             arrival_time: item[:select_arrival_time],
                             price: item[:select_price])
  end

  def self.add_new_item(item, new_number_id)
    find_or_create(number_id: new_number_id,
                   departure_city: item[:select_departure_city],
                   arrival_city: item[:select_arrival_city],
                   departure_time: item[:select_departure_time],
                   arrival_time: item[:select_arrival_time],
                   price: item[:select_price])
  end
end

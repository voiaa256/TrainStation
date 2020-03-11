# frozen_string_literal: true

require 'sequel'
require_relative 'schedule'
# model for a schedules datatable
class Schedule < Sequel::Model(:schedules)

  def self.returnDepartureAndTimeInterval(item)
    query = 'select * from schedules
    where departure_city like "' + item[:select_departure_city] + '"'
    db[query].all
  end

  def self.returnAllCityWithoutDeparture
    query = 'select distinct arrival_city city from schedules
    except select distinct departure_city city from schedules'
    db[query].all
  end

  def self.returnAllCityWithTrainStation
    query = 'select departure_city city from schedules
    union select arrival_city city from schedules'
    db[query].all
  end
  def self.update_schedule(item, schedule_id)
    self[schedule_id].update(number: item[:select_number],
                             departure_city: item[:select_departure_city],
                             arrival_city: item[:select_arrival_city],
                             departure_time: item[:select_departure_time],
                             arrival_time: item[:select_arrival_time],
                             price: item[:select_price])
  end

  def self.add_new_item(item)
    find_or_create(number: item[:select_number],
                   departure_city: item[:select_departure_city],
                   arrival_city: item[:select_arrival_city],
                   departure_time: item[:select_departure_time],
                   arrival_time: item[:select_arrival_time],
                   price: item[:select_price])
  end
end

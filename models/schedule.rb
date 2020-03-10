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
end

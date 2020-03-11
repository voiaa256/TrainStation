# frozen_string_literal: true

# all_items route
class App
  hash_branch('all_schedules') do |r|
    set_layout_options template: '../views/layout'
    set_view_subdir 'all_schedules'

    r.is do
      r.get do
        @schedules = Schedule
        view :all_schedules
      end
    end

    r.on 'departureAndTimeInterval' do
      r.get do
        @result = SuccessfullResult.new
        view :interval_date_form
      end

      r.post do
        symboled_params = r.params.map { |key, value| [key.to_sym, value] }.to_h
        @schedules = Schedule.return_departure_and_time_interval(symboled_params)
        view :all_schedules
      end
    end

    r.on 'cityWithoutDeparture' do
      r.get do
        @cities = Schedule.return_all_city_without_departure
        view :cities
      end
    end

    r.on 'cityWithTrainStation' do
      r.get do
        @cities = Schedule.return_all_city_with_train_station
        view :cities
      end
    end
  end
end

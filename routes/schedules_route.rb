# frozen_string_literal: true

# class for routing
class App
  hash_branch('schedules') do |r|
    set_layout_options template: '../views/layout'
    set_view_subdir 'schedules'

    r.is do
      r.get do
        @page_number = r.params['page_number']&.to_i || 0
        schedules = Schedule
        @count = schedules.count
        @pages_count = (@count.to_f / 5).ceil - 1
        @schedules = schedules.limit(5, @page_number * 5).all
        view :schedules
      end
    end

    r.on Integer do |schedule_id|
      r.on 'edit' do
        r.get do
          r.redirect '/schedules' if Schedule.find(id: schedule_id).nil?
          @schedule = Schedule[schedule_id]
          @errors = {}
          view :edit_form
        end

        r.post do
          @result = validate_contract(SchedulesContract, r.params)
          if @result.failure?
            @schedule = Schedule[schedule_id]
            @errors = @result.errors.to_h
            view :edit_form
          else
            symbol_params = r.params.map { |key, value| [key.to_sym, value] }.to_h
            Schedule.update_schedule(symbol_params, schedule_id)
            r.redirect '/schedules'
          end
        end
      end

      r.on 'delete' do
        r.get do
          r.redirect '/schedules' if Schedule.find(id: schedule_id).nil?
          @schedule = Schedule[schedule_id]
          view :delete_form
        end

        r.post do
          Schedule[schedule_id].destroy unless Schedule.find(id: schedule_id).nil?
          r.redirect '/schedules'
        end
      end
    end

    r.on 'new' do
      r.get do
        @result = SuccessfullResult.new
        view :create_form
      end

      r.post do
        @result = validate_contract(SchedulesContract, r.params)
        if @result.failure?
          @errors = @result.errors.to_h
          view :create_form
        else
          symboled_params = r.params.map { |key, value| [key.to_sym, value] }.to_h
          Schedule.add_new_item(symboled_params)
          r.redirect '/schedules'
        end
      end
    end
  end
end

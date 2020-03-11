# frozen_string_literal: true

# class for routing
class App
  hash_branch('schedules') do |r|
    set_layout_options template: '../views/layout'
    set_view_subdir 'schedules'

    r.is do
      r.get do
        @search = r.params['search']
        @selection = r.params['select']
        @page_number = r.params['page_number']&.to_i || 0
        schedules = Schedule.search_by(@search, @selection) || Schedule
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
          @number = Number
          @errors = {}
          view :edit_form
        end

        r.post do
          @result = validate_contract(SchedulesContract, r.params)
          if @result.failure?
            @schedule = Schedule[schedule_id]
            @number = Number
            view :edit_form
          else
            symbol_params = r.params.map { |key, value| [key.to_sym, value] }.to_h
            new_number_id = Number.find_or_create(number: symbol_params[:select_number])[:id]
            Schedule.update_schedule(new_number_id, symbol_params, schedule_id)
            r.redirect '/schedules'
          end
        end
      end

      r.on 'delete' do
        r.get do
          r.redirect '/schedules' if Schedule.find(id: schedule_id).nil?
          @schedule = Schedule[schedule_id]
          @number = Number
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
        @number = Number
        view :create_form
      end

      r.post do
        @result = validate_contract(SchedulesContract, r.params)
        if @result.failure?
          @number = Number
          view :create_form
        else
          symboled_params = r.params.map { |key, value| [key.to_sym, value] }.to_h
          new_number_id = Number.find_or_create(number: symboled_params[:select_number])[:id]
          Schedule.add_new_item(symboled_params, new_number_id)
          r.redirect '/schedules'
        end
      end
    end
  end
end

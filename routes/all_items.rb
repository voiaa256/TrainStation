# frozen_string_literal: true

# all_items route
class App
  hash_branch('all_schedules') do |r|
    set_layout_options template: '../views/layout'
    set_view_subdir 'all_schedules'

    r.is do
      r.get do
        @search = r.params['search']
        @selection = r.params['select']
        @page_number = r.params['page_number']&.to_i || 0
        schedules = Schedule.search_by(@search, @selection) || Schedule
        @schedules = schedules
        view :all_schedules
      end
    end
  end
end

# frozen_string_literal: true

require 'rubocop/rake_task'
require 'Time'
require 'sequel'
require 'json'

RuboCop::RakeTask.new

namespace :db do
  desc 'Run migrations'
  task :migrate, [:version] do |_, args|
    Sequel.extension :migration
    version = args[:version].to_i if args[:version]
    Sequel.connect('sqlite://db/schedules.db') do |db|
      Sequel::Migrator.run(db, 'migrations', target: version)
    end
  end
end

namespace :db do
  desc 'Fill database'
  task :fill_base do |_, _|
    Sequel.connect('sqlite://db/schedules.db') do |db|
      city_one = db[:cities].insert(city_name: 'Moscow')
      city_two = db[:cities].insert(city_name: 'Sain-Petersburg')
      city_three = db[:cities].insert(city_name: 'Yaroslavl')
      city_four = db[:cities].insert(city_name: 'Cherepovets')
      city_five = db[:cities].insert(city_name: 'Sochi')
      city_six = db[:cities].insert(city_name: 'Kazan')

      db[:schedules].insert(number: 601, departure_city_id:city_one, arrival_city_id:city_two, 
        departure_time: Time.new(2020, 3, 10, 21, 0, 0).to_s, arrival_time:Time.new(2020, 3, 11, 12, 0, 0).to_s, price: 3000)

      db[:schedules].insert(number: 602, departure_city_id:city_four, arrival_city_id:city_three, 
        departure_time: Time.new(2020, 3, 10, 18, 0, 0).to_s, arrival_time:Time.new(2020, 3, 11, 4, 30, 0).to_s, price: 1500)

      db[:schedules].insert(number: 603, departure_city_id:city_three, arrival_city_id:city_four, 
        departure_time: Time.new(2020, 3, 11, 9, 0, 0).to_s, arrival_time:Time.new(2020, 3, 11, 19, 30, 0).to_s, price: 1500)

      db[:schedules].insert(number: 604, departure_city_id:city_two, arrival_city_id:city_one, 
        departure_time: Time.new(2020, 3, 11, 15, 0, 0).to_s, arrival_time:Time.new(2020, 3, 12, 5, 0, 0).to_s, price: 3000)

      db[:schedules].insert(number: 605, departure_city_id:city_one, arrival_city_id:city_five, 
        departure_time: Time.new(2020, 3, 10, 9, 0, 0).to_s, arrival_time:Time.new(2020, 3, 12, 9, 0, 0).to_s, price: 5000)

      db[:schedules].insert(number: 606, departure_city_id:city_one, arrival_city_id:city_six, 
        departure_time: Time.new(2020, 3, 10, 10, 0, 0).to_s, arrival_time:Time.new(2020, 3, 11, 12, 0, 0).to_s, price: 3500)

      db[:schedules].insert(number: 607, departure_city_id:city_one, arrival_city_id:city_three, 
        departure_time: Time.new(2020, 3, 10, 10, 0, 0).to_s, arrival_time:Time.new(2020, 3, 10, 18, 0, 0).to_s, price: 1250)

      db[:schedules].insert(number: 608, departure_city_id:city_one, arrival_city_id:city_four, 
        departure_time: Time.new(2020, 3, 10, 21, 0, 0).to_s, arrival_time:Time.new(2020, 3, 11, 6, 45, 0).to_s, price: 2000)

      db[:schedules].insert(number: 609, departure_city_id:city_four, arrival_city_id:city_two, 
        departure_time: Time.new(2020, 3, 10, 21, 0, 0).to_s, arrival_time:Time.new(2020, 3, 11, 9, 0, 0).to_s, price: 2500)

      db[:schedules].insert(number: 610, departure_city_id:city_two, arrival_city_id:city_four, 
        departure_time: Time.new(2020, 3, 11, 12, 0, 0).to_s, arrival_time:Time.new(2020, 3, 12, 0, 0, 0).to_s, price: 2500)

      db[:schedules].insert(number: 611, departure_city_id:city_two, arrival_city_id:city_three, 
        departure_time: Time.new(2020, 3, 13, 21, 0, 0).to_s, arrival_time:Time.new(2020, 3, 14, 11, 30, 0).to_s, price: 3250)
      end
  end
end

namespace :server do
  desc 'Start server'
  task :start do
    filepath = File.expand_path('./db/schedules.db', __dir__)
    unless File.exist? filepath
      Rake::Task['db:migrate'].invoke
      Rake::Task['db:fill_base'].invoke
    end
    `rerun rackup`
  end
end

task :default do
  Rake::Task['server:start'].invoke
end

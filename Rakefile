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
      db[:schedules].insert(number: 1, departure_city: 'Moscow', arrival_city: 'Saint-Petersburg',
                            departure_time: Time.new(2020, 3, 10, 21, 0, 0).to_s,
                            arrival_time: Time.new(2020, 3, 11, 12, 0, 0).to_s, price: 3000)

      db[:schedules].insert(number: 2, departure_city: 'Cherepovets', arrival_city: 'Yaroslavl',
                            departure_time: Time.new(2020, 3, 10, 18, 0, 0).to_s,
                            arrival_time: Time.new(2020, 3, 11, 4, 30, 0).to_s, price: 1500)

      db[:schedules].insert(number: 3, departure_city: 'Yaroslavl', arrival_city: 'Cherepovets',
                            departure_time: Time.new(2020, 3, 11, 9, 0, 0).to_s,
                            arrival_time: Time.new(2020, 3, 11, 19, 30, 0).to_s, price: 1500)

      db[:schedules].insert(number: 4, departure_city: 'Saint-Petersburg', arrival_city: 'Moscow',
                            departure_time: Time.new(2020, 3, 11, 15, 0, 0).to_s,
                            arrival_time: Time.new(2020, 3, 12, 5, 0, 0).to_s, price: 3000)

      db[:schedules].insert(number: 5, departure_city: 'Moscow', arrival_city: 'Sochi',
                            departure_time: Time.new(2020, 3, 10, 9, 0, 0).to_s,
                            arrival_time: Time.new(2020, 3, 12, 9, 0, 0).to_s, price: 5000)

      db[:schedules].insert(number: 6, departure_city: 'Moscow', arrival_city: 'Kazan',
                            departure_time: Time.new(2020, 3, 10, 10, 0, 0).to_s,
                            arrival_time: Time.new(2020, 3, 11, 12, 0, 0).to_s, price: 3500)

      db[:schedules].insert(number: 7, departure_city: 'Moscow', arrival_city: 'Yaroslavl',
                            departure_time: Time.new(2020, 3, 10, 10, 0, 0).to_s,
                            arrival_time: Time.new(2020, 3, 10, 18, 0, 0).to_s, price: 1250)

      db[:schedules].insert(number: 8, departure_city: 'Moscow', arrival_city: 'Cherepovets',
                            departure_time: Time.new(2020, 3, 10, 21, 0, 0).to_s,
                            arrival_time: Time.new(2020, 3, 11, 6, 45, 0).to_s, price: 2000)

      db[:schedules].insert(number: 9, departure_city: 'Cherepovets', arrival_city: 'Saint-Petersburg',
                            departure_time: Time.new(2020, 3, 10, 21, 0, 0).to_s,
                            arrival_time: Time.new(2020, 3, 11, 9, 0, 0).to_s, price: 2500)

      db[:schedules].insert(number: 10, departure_city: 'Saint-Petersburg', arrival_city: 'Cherepovets',
                            departure_time: Time.new(2020, 3, 11, 12, 0, 0).to_s,
                            arrival_time: Time.new(2020, 3, 12, 0, 0, 0).to_s, price: 2500)

      db[:schedules].insert(number: 11, departure_city: 'Saint-Petersburg', arrival_city: 'Yaroslavl',
                            departure_time: Time.new(2020, 3, 13, 21, 0, 0).to_s,
                            arrival_time: Time.new(2020, 3, 14, 11, 30, 0).to_s, price: 3250)
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

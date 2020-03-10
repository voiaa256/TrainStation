# frozen_string_literal: true

require 'roda'
require 'sequel'
require 'sqlite3'
require_relative 'helpers/contract_helper'
require_relative 'helpers/successfull_result'

# app class
class App < Roda
  plugin :render
  plugin :public
  plugin :hash_routes
  plugin :view_options
  DB = Sequel.connect("sqlite:///#{File.expand_path('./db/schedules.db', __dir__)}")
  require_relative 'models/schedule'
  require_relative 'models/city'

  include ContractHelper

  require_relative 'routes/home_page_route'
  require_relative 'routes/all_items'

  route do |r|
    r.public
    r.hash_branches
    r.root do
      r.redirect '/home_page'
    end
  end
end

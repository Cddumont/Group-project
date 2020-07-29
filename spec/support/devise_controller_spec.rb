require "rails_helper"

RSpec.configure do |config|
  config.include Devise::Test::ControllerHelpers, type: :controller
end
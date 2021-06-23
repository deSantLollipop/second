RSpec.configure do |config|
  config.include Devise::Test::ControllerHelpers, type: :controller
end

config.include Devise::Test::ControllerHelpers, type: :controller
if config.environment == 'test'
  require 'test_helpers'
  require 'test/unit'
  Test::Unit::TestCase.class_eval do
    include TestHelpers
  end
end
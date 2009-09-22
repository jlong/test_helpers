require 'test/unit'
require 'lib/test_helpers'
require 'rubygems'
gem 'activesupport'
require 'active_support'

class TestHelpersTest < Test::Unit::TestCase
  
  include TestHelpers
  self.test_helper_path = File.dirname(__FILE__) + '/helpers'
  
  def test_it
    self.class.test_helper :just_a_test
    assert_equal 'hello world!', hello
  end
  
end
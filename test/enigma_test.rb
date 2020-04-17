require 'simplecov'
SimpleCov.start
require 'minitest/autorun'
require 'minitest/pride'
require './lib/encrypt'
require './lib/enigma'

require 'pry'

class EnigmaTest < Minitest::Test

  def test_case_name
    enigma =  Enigma.new
    assert_equal "", enigma.encrypt
  end

end

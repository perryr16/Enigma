require 'simplecov'
SimpleCov.start
require 'minitest/autorun'
require 'minitest/pride'
require './lib/key_date'
require 'mocha/minitest'

require 'pry'

class KeyDateTest < Minitest::Test

  def test_it_exists
    key_date = KeyDate.new
    assert_instance_of KeyDate, key_date
  end

  def test_today_returns_date_as_integer
    key_date = KeyDate.new

    assert_equal 160420, key_date.today
    Date.stubs(:today).returns(Date.new(1991, 05, 13))
    assert_equal 130591, key_date.today
  end

  def test_it_returns_a_5_digit_string
    key_date = KeyDate.new
    assert_equal 5, key_date.five_digit.length
    assert_equal true, key_date.five_digit.to_i < 100000
    assert_equal true, key_date.five_digit.to_i > 0
  end

  def test_keys
    key_date = KeyDate.new
    key_date.stubs(:five_digit).returns("01020")
    assert_equal 1, key_date.a_key
  end

end

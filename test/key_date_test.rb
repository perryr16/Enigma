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
    Date.stubs(:today).returns(Date.new(1990, 10, 03))
    assert_equal 31090, key_date.today
    Date.stubs(:today).returns(Date.new(1555, 11, 23))
    assert_equal 231155, key_date.today
  end

  def test_offests
    key_date = KeyDate.new
    Date.stubs(:today).returns(Date.new(1991, 05, 13))
    #9281
    key_date.offsets
    assert_equal 9, key_date.a_offset
    assert_equal 2, key_date.b_offset
    assert_equal 8, key_date.c_offset
    assert_equal 1, key_date.d_offset
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
    key_date.keys
    assert_equal 1, key_date.a_key
    assert_equal 10, key_date.b_key
    assert_equal 2, key_date.c_key
    assert_equal 20, key_date.d_key
  end

end

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

  def test_date_squared
    key_date = KeyDate.new
    Date.stubs(:today).returns(Date.new(1991, 05, 13))
    #9281
    assert_equal [9,2,8,1], key_date.date_squared
  end

  def test_offests
    key_date = KeyDate.new
    Date.stubs(:today).returns(Date.new(1991, 05, 13))
    #9281
    date_squared = key_date.date_squared(key_date.today)
    assert_equal 9, key_date.offsets(date_squared)[0]
    assert_equal 2, key_date.offsets(date_squared)[1]
    assert_equal 8, key_date.offsets(date_squared)[2]
    assert_equal 1, key_date.offsets(date_squared)[3]
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
    number = key_date.five_digit
    assert_equal 1, key_date.keys(number)[0]
    assert_equal 10, key_date.keys(number)[1]
    assert_equal 2, key_date.keys(number)[2]
    assert_equal 20, key_date.keys(number)[3]
  end

  def test_shifts
    key_date = KeyDate.new
    key_date.stubs(:five_digit).returns("01020")
    Date.stubs(:today).returns(Date.new(1991, 05, 13))
    number = key_date.five_digit

    key_date.shifts(number, key_date.today)
    assert_equal 10, key_date.a_shift
    assert_equal 12, key_date.b_shift
    assert_equal 10, key_date.c_shift
    assert_equal 21, key_date.d_shift

    key_date.shifts(nil, key_date.today)
    assert_equal 10, key_date.a_shift
    assert_equal 12, key_date.b_shift
    assert_equal 10, key_date.c_shift
    assert_equal 21, key_date.d_shift
  end

  # def test_case_name
  #   key_date = KeyDate.new
  #
  #   binding.pry
  # end


end

require 'simplecov'
SimpleCov.start
require 'minitest/autorun'
require 'minitest/pride'
require './lib/shiftable'
require './lib/encrypt'
require 'mocha/minitest'

require 'pry'

class ShiftableTest < Minitest::Test

  def test_it_exists
    shiftable = Encrypt.new
    shiftable.extend(Shiftable)
    assert_instance_of Encrypt, shiftable
  end

  def test_today_returns_date_as_integer
    shiftable = Encrypt.new
    shiftable.extend(Shiftable)

    # assert_equal 170420, shiftable.today
    Date.stubs(:today).returns(Date.new(1990, 10, 03))
    assert_equal 31090, shiftable.today
    Date.stubs(:today).returns(Date.new(1555, 11, 23))
    assert_equal 231155, shiftable.today
  end

  def test_date_squared
    shiftable = Encrypt.new
    shiftable.extend(Shiftable)

    Date.stubs(:today).returns(Date.new(1991, 05, 13))
    #9281
    assert_equal [9,2,8,1], shiftable.date_squared(shiftable.today)
  end

  def test_offests
    shiftable = Encrypt.new
    shiftable.extend(Shiftable)

    Date.stubs(:today).returns(Date.new(1991, 05, 13))
    #9281
    date_squared = shiftable.date_squared(shiftable.today)
    assert_equal 9, shiftable.offsets(date_squared)[0]
    assert_equal 2, shiftable.offsets(date_squared)[1]
    assert_equal 8, shiftable.offsets(date_squared)[2]
    assert_equal 1, shiftable.offsets(date_squared)[3]
  end
  #
  # def test_it_returns_a_5_digit_string
  #   shiftable = Shiftable.new
  #   assert_equal 5, shiftable.five_digit.length
  #   assert_equal true, shiftable.five_digit.to_i < 100000
  #   assert_equal true, shiftable.five_digit.to_i > 0
  # end
  #
  # def test_keys
  #   shiftable = Shiftable.new
  #   shiftable.stubs(:five_digit).returns("01020")
  #   number = shiftable.five_digit
  #   assert_equal 1, shiftable.keys(number)[0]
  #   assert_equal 10, shiftable.keys(number)[1]
  #   assert_equal 2, shiftable.keys(number)[2]
  #   assert_equal 20, shiftable.keys(number)[3]
  # end
  #
  # def test_shifts
  #   shiftable = Shiftable.new
  #   shiftable.stubs(:five_digit).returns("01020")
  #   Date.stubs(:today).returns(Date.new(1991, 05, 13))
  #   number = shiftable.five_digit
  #
  #   shiftable.shifts(number, shiftable.today)
  #   assert_equal 10, shiftable.a_shift
  #   assert_equal 12, shiftable.b_shift
  #   assert_equal 10, shiftable.c_shift
  #   assert_equal 21, shiftable.d_shift
  #
  #   shiftable.shifts(nil, shiftable.today)
  #   assert_equal 10, shiftable.a_shift
  #   assert_equal 12, shiftable.b_shift
  #   assert_equal 10, shiftable.c_shift
  #   assert_equal 21, shiftable.d_shift
  # end

  # def test_case_name
  #   shiftable = Shiftable.new
  #
  #   binding.pry
  # end


end

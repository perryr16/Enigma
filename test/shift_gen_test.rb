require 'simplecov'
SimpleCov.start
require 'minitest/autorun'
require 'minitest/pride'
require './lib/shift_gen'
require 'mocha/minitest'

require 'pry'

class Shif_genTest < Minitest::Test

  def test_it_exists
    shift_gen = ShiftGen.new
    assert_instance_of ShiftGen, shift_gen
  end

  def test_today_returns_date_as_integer
    shift_gen = ShiftGen.new

    # assert_equal 170420, shift_gen.today
    Date.stubs(:today).returns(Date.new(1990, 10, 03))
    assert_equal 31090, shift_gen.today
    Date.stubs(:today).returns(Date.new(1555, 11, 23))
    assert_equal 231155, shift_gen.today
  end


  def test_offests
    shift_gen = ShiftGen.new

    Date.stubs(:today).returns(Date.new(1991, 05, 13))
    #9281
    date = shift_gen.today
    assert_equal 9, shift_gen.offsets(date)[0]
    assert_equal 2, shift_gen.offsets(date)[1]
    assert_equal 8, shift_gen.offsets(date)[2]
    assert_equal 1, shift_gen.offsets(date)[3]
  end

  def test_it_returns_a_5_digit_string
    shift_gen = ShiftGen.new

    assert_equal 5, shift_gen.five_digit.length
    assert_equal true, shift_gen.five_digit.to_i < 100000
    assert_equal true, shift_gen.five_digit.to_i > 0
  end

  def test_shifts
    shift_gen = ShiftGen.new

    shift_gen.stubs(:five_digit).returns("01020")
    Date.stubs(:today).returns(Date.new(1991, 05, 13))
    number = shift_gen.five_digit

    shift_gen.shifts(number, shift_gen.today)
    assert_equal 10, shift_gen.a_shift
    assert_equal 12, shift_gen.b_shift
    assert_equal 10, shift_gen.c_shift
    assert_equal 21, shift_gen.d_shift

    shift_gen.shifts(nil, shift_gen.today)
    assert_equal 10, shift_gen.a_shift
    assert_equal 12, shift_gen.b_shift
    assert_equal 10, shift_gen.c_shift
    assert_equal 21, shift_gen.d_shift
  end

end

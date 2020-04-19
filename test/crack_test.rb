require 'simplecov'
SimpleCov.start
require 'minitest/autorun'
require 'minitest/pride'
require 'pry'
require 'mocha/minitest'
require './lib/crack'
require './lib/alpha_num'


class CrackTest < Minitest::Test

  def test_it_exists
    crack = Crack.new
    assert_instance_of Crack, crack
  end

  def test_it_returns_delta_end
    crack = Crack.new
    expected = {space: 0, e: 0, n: 0, d: 0}
    assert_equal expected, crack.delta_end(" end")
    expected = {space: 1, e: 1, n: 1, d: 1}
    assert_equal expected, crack.delta_end("afoe")
    expected = {space: 1, e: 2, n: 3, d: 4}
    assert_equal expected, crack.delta_end("agqh")
    expected = {space: 26, e: 26, n: 26, d: 26}
    assert_equal expected, crack.delta_end("zdmc")
  end
  # 
  # def test_crack_a_index
  #   crack = Crack.new
  #   assert_equal -4, crack.crack_a_index(" end")
  #   assert_equal -3, crack.crack_a_index("x end")
  #   assert_equal -2, crack.crack_a_index("xx end")
  #   assert_equal -1, crack.crack_a_index("xxx end")
  #   assert_equal -4, crack.crack_a_index("xxxx end")
  # end

  def test_crack_indexes
    crack = Crack.new

    assert_equal [-4, -3, -2, -1], crack.crack_indexes(" end")
    assert_equal [-4, -3, -2, -1], crack.crack_indexes("xxxx end")
    assert_equal [-1, -4, -3, -2], crack.crack_indexes("x end")
    assert_equal [-2, -1, -4, -3], crack.crack_indexes("xx end")
    assert_equal [-3, -2, -1, -4], crack.crack_indexes("xxx end")
  end



end

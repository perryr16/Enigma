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

  # def test_it_returns_delta_end
  #   crack = Crack.new
  #   expected = {space: 0, e: 0, n: 0, d: 0}
  #   assert_equal expected, crack.delta_end(" end")
  #   expected = {space: 1, e: 1, n: 1, d: 1}
  #   assert_equal expected, crack.delta_end("afoe")
  #   expected = {space: 1, e: 2, n: 3, d: 4}
  #   assert_equal expected, crack.delta_end("agqh")
  #   expected = {space: 26, e: 26, n: 26, d: 26}
  #   assert_equal expected, crack.delta_end("zdmc")
  # end
  #
  # def test_crack_a_index
  #   crack = Crack.new
  #   assert_equal -4, crack.crack_a_index(" end")
  #   assert_equal -3, crack.crack_a_index("x end")
  #   assert_equal -2, crack.crack_a_index("xx end")
  #   assert_equal -1, crack.crack_a_index("xxx end")
  #   assert_equal -4, crack.crack_a_index("xxxx end")
  # end

  # def test_crack_indexes
  #   crack = Crack.new
  #   expected = {a: -4, b: -3, c: -2, d: -1}
  #   assert_equal expected, crack.crack_indexes(" end")
  #   assert_equal expected, crack.crack_indexes("xxxx end")
  #   expected = {a: -1, b: -4, c: -3, d: -2}
  #   assert_equal expected, crack.crack_indexes("x end")
  #   expected = {a: -2, b: -1, c: -4, d: -3}
  #   assert_equal expected, crack.crack_indexes("xx end")
  #   expected = {a: -3, b: -2, c: -1, d: -4}
  #   assert_equal expected, crack.crack_indexes("xxx end")
  # end

  def test_crack_shift
    crack = Crack.new
    expected = {:a=>0, :b=>1, :c=>2, :d=>3}
    assert_equal expected, crack.crack_shift(" fpg")
    expected = {:a=>3, :b=>0, :c=>1, :d=>2}
    assert_equal expected, crack.crack_shift("x fpg")
    expected = {:a=>2, :b=>3, :c=>0, :d=>1}
    assert_equal expected, crack.crack_shift("xx fpg")
    assert_equal expected, crack.crack_shifts
    expected = {:a=>1, :b=>2, :c=>3, :d=>0}
    assert_equal expected, crack.crack_shift("xxx fpg")
    assert_equal expected, crack.crack_shifts
  end



end

require 'simplecov'
SimpleCov.start
require 'minitest/autorun'
require 'minitest/pride'
require 'pry'
require 'mocha/minitest'
require './lib/crack'
require './lib/alpha_num'
require './lib/shift_gen'


class CrackTest < Minitest::Test

  def test_it_exists
    crack = Crack.new
    assert_instance_of Crack, crack
  end

  def test_delta_end
    crack =  Crack.new
    expected = {:space=>0, :e=>0, :n=>0, :d=>0}
    assert_equal expected, crack.delta_end(" end")
    expected = {:space=>0, :e=>1, :n=>0, :d=>0}
    assert_equal expected, crack.delta_end(" fnd")
    expected = {:space=>1, :e=>23, :n=>14, :d=>24}
    assert_equal expected, crack.delta_end("aaaa")
  end

  def test_crack_shift
    crack = Crack.new
    expected = {:a=>0, :b=>1, :c=>2, :d=>3}
    assert_equal expected, crack.crack_shift(" fpg")
    expected = {:a=>3, :b=>0, :c=>1, :d=>2}
    assert_equal expected, crack.crack_shift("x fpg")
    expected = {:a=>2, :b=>3, :c=>0, :d=>1}
    assert_equal expected, crack.crack_shift("xx fpg")
    # assert_equal expected, crack.crack_shifts
    expected = {:a=>1, :b=>2, :c=>3, :d=>0}
    assert_equal expected, crack.crack_shift("xxx fpg")
    # assert_equal expected, crack.crack_shifts
  end

  def test_all_possible_keys
    crack = Crack.new
    assert_equal ["18", "45", "72", "99"], crack.all_possible_keys("x ev","190420", :a, 0)
    assert_equal ["18", "45", "72", "99"], crack.all_possible_keys("x ev","190420", :b, 1)
    assert_equal ["18", "45", "72", "99"], crack.all_possible_keys("x ev","190420", :c, 2)
    assert_equal ["18", "45", "72", "99"], crack.all_possible_keys("x ev","190420", :d, 3)

    assert_equal ["12", "39", "66", "93"], crack.all_possible_keys("reuv","190420", :a, 0)
    assert_equal ["23", "50", "77"], crack.all_possible_keys("reuv","190420", :b, 1)
    assert_equal ["07", "34", "61", "88"], crack.all_possible_keys("reuv","190420", :c, 2)
    assert_equal ["18", "45", "72", "99"], crack.all_possible_keys("reuv","190420", :d, 3)
  end

  def test_a_keys
    crack = Crack.new
    assert_equal ["18", "45", "72", "99"], crack.a_keys("x ev","190420")
    assert_equal ["12", "39", "66", "93"], crack.a_keys("reuv","190420")
  end

  def test_the_key
    crack = Crack.new
    assert_equal "23", crack.the_key("reuv","190420", :b, 1, "2")
    assert_equal "34", crack.the_key("reuv","190420", :c, 2, "3")
    assert_equal "45", crack.the_key("reuv","190420", :d, 3, "4")

    assert_equal "99", crack.the_key("x ev","190420", :b, 1, "9")
    assert_equal "99", crack.the_key("x ev","190420", :c, 2, "9")
    assert_equal "99", crack.the_key("x ev","190420", :d, 3, "9")
  end

  def test_four_good_keys
    crack = Crack.new
    assert_equal ["12", "23", "34", "45"], crack.four_good_keys("reuv", "190420")
    assert_equal ["99", "99", "99", "99"], crack.four_good_keys("x ev", "190420")
    assert_equal ["01", "10", "01", "10"], crack.four_good_keys("gson", "190420")
    assert_equal ["99", "99", "99", "99"], crack.four_good_keys("x ev", "190420")
  end

  def test_cracked_key
    crack = Crack.new
    assert_equal "12345", crack.cracked_key("reuv", "190420")
    assert_equal "99999", crack.cracked_key("x ev", "190420")
    assert_equal "01010", crack.cracked_key("gson", "190420")
    assert_equal "86593", crack.cracked_key("ktsp", "190420")
  end

end

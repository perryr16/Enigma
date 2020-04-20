require 'simplecov'
SimpleCov.start
require 'minitest/autorun'
require 'minitest/pride'
require 'pry'
require 'mocha/minitest'
require './lib/crack_algorithm'
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
    assert_equal "12345", crack.cracked_key("khlrvelireuafygwstpey i jca ks,rsnkrkhlruocjrcherdheueg x  zwygnsn rkogwed", "190420")
  end


  def test_it_creates_a_hash_of_aplha_to_numbers
    crack = Crack.new

    expected = {"a"=>0, "b"=>1, "c"=>2, "d"=>3, "e"=>4, "f"=>5, "g"=>6, "h"=>7,
                "i"=>8, "j"=>9, "k"=>10, "l"=>11, "m"=>12, "n"=>13, "o"=>14,
                "p"=>15, "q"=>16, "r"=>17, "s"=>18, "t"=>19, "u"=>20, "v"=>21,
                "w"=>22, "x"=>23, "y"=>24, "z"=>25, " "=>26}
                # binding.pry
    assert_equal expected, crack.a_one
  end

  def test_it_creaters_a_hash_of_numeric_to_alpha
    crack = Crack.new

    expected = {0=>"a", 1=>"b", 2=>"c", 3=>"d", 4=>"e", 5=>"f", 6=>"g", 7=>"h",
                8=>"i", 9=>"j", 10=>"k", 11=>"l", 12=>"m", 13=>"n", 14=>"o",
                15=>"p", 16=>"q", 17=>"r", 18=>"s", 19=>"t", 20=>"u", 21=>"v",
                22=>"w", 23=>"x", 24=>"y", 25=>"z", 26=>" "}
    assert_equal expected, crack.one_a
  end

end

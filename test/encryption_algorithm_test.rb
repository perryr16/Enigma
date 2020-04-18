require 'simplecov'
SimpleCov.start
require 'minitest/autorun'
require 'minitest/pride'
require 'pry'
require 'mocha/minitest'
require './lib/encryption_algorithm'



class EncryptTest < Minitest::Test

  def setup
    @encrypt = EncryptionAlgorithm.new

    @the_message = "brown fox? sleepy dog! end"
  end

  def test_it_exists
    assert_instance_of EncryptionAlgorithm, @encrypt
  end

  def test_it_returns_a_split_list_of_characters
    expected = ["b", "r", "o", "w", "n", " ", "f", "o", "x", "?", " ", "s", "l", "e", "e", "p", "y", " ", "d", "o", "g", "!", " ", "e", "n", "d"]
    assert_equal expected, @encrypt.split_characters(@the_message)
  end

  def test_it_creates_a_hash_of_aplha_to_numbers
    expected = {"a"=>0, "b"=>1, "c"=>2, "d"=>3, "e"=>4, "f"=>5, "g"=>6, "h"=>7,
                "i"=>8, "j"=>9, "k"=>10, "l"=>11, "m"=>12, "n"=>13, "o"=>14,
                "p"=>15, "q"=>16, "r"=>17, "s"=>18, "t"=>19, "u"=>20, "v"=>21,
                "w"=>22, "x"=>23, "y"=>24, "z"=>25, " "=>26}
                # binding.pry
    assert_equal expected, @encrypt.alpha_num.a_one
  end

  def test_it_creaters_a_hash_of_numeric_to_alpha
    expected = {0=>"a", 1=>"b", 2=>"c", 3=>"d", 4=>"e", 5=>"f", 6=>"g", 7=>"h",
                8=>"i", 9=>"j", 10=>"k", 11=>"l", 12=>"m", 13=>"n", 14=>"o",
                15=>"p", 16=>"q", 17=>"r", 18=>"s", 19=>"t", 20=>"u", 21=>"v",
                22=>"w", 23=>"x", 24=>"y", 25=>"z", 26=>" "}
    assert_equal expected, @encrypt.alpha_num.one_a
  end

  def test_it_transforms_alpha_to_numeric
    expected = [1, 17, 14, 22, 13, 26, 5, 14, 23, "?", 26, 18, 11, 4, 4, 15, 24, 26, 3, 14, 6, "!", 26, 4, 13, 3]
    assert_equal expected, @encrypt.to_numeric(@the_message)
  end

  def test_it_creates_arrays_every_4th_position
    message = @the_message
    assert_equal [1, 13, 23, 11, 24, 6, 13], @encrypt.split_4th(message)[0]
    assert_equal [17, 26, "?", 4, 26, "!", 3], @encrypt.split_4th(message)[1]
    assert_equal [14, 5, 26, 4, 3, 26] , @encrypt.split_4th(message)[2]
    assert_equal [22, 14, 18, 15, 14, 4], @encrypt.split_4th(message)[3]
  end

  def test_it_shifts_letters
    message = @the_message

    a_code = @encrypt.split_4th(message)[0]
    b_code = @encrypt.split_4th(message)[1]
    c_code = @encrypt.split_4th(message)[2]
    d_code = @encrypt.split_4th(message)[3]
    assert_equal [2, 14, 24, 12, 25, 7, 14], @encrypt.shift(a_code, 1)
    assert_equal [2, 14, 24, 12, 25, 7, 14], @encrypt.shift(a_code, 28)
    assert_equal [19, 1, "?", 6, 1, "!", 5], @encrypt.shift(b_code, 2)
    assert_equal [17, 8, 2, 7, 6, 2], @encrypt.shift(c_code, 3)
    assert_equal [26, 18, 22, 19, 18, 8], @encrypt.shift(d_code, 4)
  end


  def test_it_zips_back_together
    message = @the_message

    expected = [2, 19, 17, 26, 14, 1, 8, 18, 24, "?", 2, 22, 12, 6, 7, 19, 25, 1, 6, 18, 7, "!", 2, 8, 14, 5]
    assert_equal expected, @encrypt.zip_together(message, 1,2,3,4)
  end

  def test_it_transforms_numeric_to_alpha
    message = @the_message

    expected = "ctr obisy?cwmghtzbgsh!ciof"
    numeric_message = @encrypt.zip_together(message, 1,2,3,4)
    assert_equal  expected, @encrypt.to_alpha(numeric_message)
  end


end

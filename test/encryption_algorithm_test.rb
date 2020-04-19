require 'simplecov'
SimpleCov.start
require 'minitest/autorun'
require 'minitest/pride'
require 'pry'
require 'mocha/minitest'
require './lib/encryption_algorithm'
require './lib/alpha_num'
require './lib/shift_gen'


class EncryptionAlgorithmTest < Minitest::Test

  def setup
    @encrypt = EncryptionAlgorithm.new
    @the_message = "brown fox? sleepy dog! end"
  end

  def test_it_exists
    assert_instance_of EncryptionAlgorithm, @encrypt
  end

  def test_it_returns_message
    assert_equal [], @encrypt.message
  end

  def test_it_couples
    @encrypt.couple
    assert_instance_of AlphaNum, @encrypt.alpha_num
    assert_instance_of ShiftGen, @encrypt.shift_gen
  end


  def test_it_returns_a_split_list_of_characters
    expected = ["b", "r", "o", "w", "n", " ", "f", "o", "x", "?", " ", "s", "l", "e", "e", "p", "y", " ", "d", "o", "g", "!", " ", "e", "n", "d"]
    assert_equal expected, @encrypt.split_characters(@the_message)
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

  def test_it_backwards_shifts_letters
    message = @the_message

    a_code = @encrypt.split_4th(message)[0]
    b_code = @encrypt.split_4th(message)[1]
    c_code = @encrypt.split_4th(message)[2]
    d_code = @encrypt.split_4th(message)[3]
    assert_equal [0, 12, 22, 10, 23, 5, 12], @encrypt.shift(a_code, 1, -1)
    assert_equal [0, 12, 22, 10, 23, 5, 12], @encrypt.shift(a_code, 28, -1)
    assert_equal [15, 24, "?", 2, 24, "!", 1], @encrypt.shift(b_code, 2, -1)
    assert_equal [11, 2, 23, 1, 0, 23], @encrypt.shift(c_code, 3, -1)
    assert_equal [18, 10, 14, 11, 10, 0], @encrypt.shift(d_code, 4, -1)
  end



  def test_it_zips_back_together_forwards_backwards
    message = @the_message

    expected = [2, 19, 17, 26, 14, 1, 8, 18, 24, "?", 2, 22, 12, 6, 7, 19, 25, 1, 6, 18, 7, "!", 2, 8, 14, 5]
    assert_equal expected, @encrypt.zip_together(message, 1,2,3,4)

    expected = [0, 15, 11, 18, 12, 24, 2, 10, 22, "?", 23, 14, 10, 2, 1, 11, 23, 24, 0, 10, 5, "!", 23, 0, 12, 1]
    assert_equal expected, @encrypt.zip_together(message, 1,2,3,4, -1)
  end

  def test_it_transforms_numeric_to_alpha
    message = @the_message

    expected = "ctr obisy?cwmghtzbgsh!ciof"
    numeric_message = @encrypt.zip_together(message, 1,2,3,4)
    assert_equal  expected, @encrypt.to_alpha(numeric_message)

  end


end

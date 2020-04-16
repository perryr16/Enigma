require 'minitest/autorun'
require 'minitest/pride'
require './lib/encrypt'

require 'pry'

class EncryptTest < Minitest::Test

  def setup
    @encrypt = Encrypt.new
    @encrypt.read_txt
    @encrypt.split_4th_index
  end

  def test_it_exists
    assert_instance_of Encrypt, @encrypt
  end

  def test_it_returns_a_message_to_encrypt_from_txt
    assert_equal ["brown fox?", "sleepy dog! end"], @encrypt.message

  end

  def test_it_returns_a_split_list_of_characters
    expected = ["b", "r", "o", "w", "n", " ", "f", "o", "x", "?", " ", "s", "l", "e", "e", "p", "y", " ", "d", "o", "g", "!", " ", "e", "n", "d"]
    assert_equal expected, @encrypt.split_characters
  end

  def test_it_creates_arrays_every_4th_position

    assert_equal ["b", "n", "x", "l", "y", "g", "n"], @encrypt.a_code
    assert_equal ["r", " ", "?", "e", " ", "!", "d"], @encrypt.b_code
    assert_equal ["o", "f", " ", "e", "d", " "], @encrypt.c_code
    assert_equal ["w", "o", "s", "p", "o", "e"], @encrypt.d_code
  end

end

require 'minitest/autorun'
require 'minitest/pride'
require './lib/encrypt'

require 'pry'

class EncryptTest < Minitest::Test

  def setup
    @encrypt = Encrypt.new
    @encrypt.read_txt
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
    assert_equal ["b", "n", "x", "l", "y", "g", "n"], @encrypt.split_4th[0]
    assert_equal ["r", " ", "?", "e", " ", "!", "d"], @encrypt.split_4th[1]
    assert_equal ["o", "f", " ", "e", "d", " "], @encrypt.split_4th[2]
    assert_equal ["w", "o", "s", "p", "o", "e"], @encrypt.split_4th[3]
  end

  def test_it_zips_back_together
    assert_equal "brown fox? sleepy dog! end", @encrypt.zip_together
  end

  def test_it_creates_a_hash_of_aplha_to_numbers
    expected = {"a"=>1, "b"=>2, "c"=>3, "d"=>4, "e"=>5, "f"=>6, "g"=>7, "h"=>8,
                "i"=>9, "j"=>10, "k"=>11, "l"=>12, "m"=>13, "n"=>14, "o"=>15,
                "p"=>16, "q"=>17, "r"=>18, "s"=>19, "t"=>20, "u"=>21, "v"=>22,
                "w"=>23, "x"=>24, "y"=>25, "z"=>26, " "=>27}
    assert_equal expected, @encrypt.a1_z26
  end

  def test_it_shifts_letters
    @encrypt.shift(@encrypt.split_4th[0], 1)
  end

end

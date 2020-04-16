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
    assert_equal ["fly like an eagle", "if the dog is blue"], @encrypt.message

  end

  def test_it_returns_a_split_list_of_characters
    expected = ["f", "l", "y", " ", "l", "i", "k", "e", " ", "a", "n", " ", "e", "a", "g", "l", "e", " ", "i", "f", " ", "t", "h", "e", " ", "d", "o", "g", " ", "i", "s", " ", "b", "l", "u", "e"]
    assert_equal expected, @encrypt.split_characters
  end

end

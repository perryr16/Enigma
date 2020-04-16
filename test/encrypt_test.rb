require 'minitest/autorun'
require 'minitest/pride'
require './lib/encrypt'

require 'pry'

class EncryptTest < Minitest::Test

  def test_it_exists
    encrypt = Encrypt.new
    assert_instance_of Encrypt, encrypt
  end

  def test_it_returns_a_message_to_encrypt_from_txt
    encrypt = Encrypt.new
    assert_equal ["fly like an eagle\n"], encrypt.read_txt
  end

end

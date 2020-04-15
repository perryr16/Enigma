require 'minitest/autorun'
require 'minitest/pride'
require './lib/encrypt'

require 'pry'

class EncryptTest < Minitest::Test

  def test_it_exists
    encryption = Encrypt.new
    assert_instance_of Encrypt, encryption
  end

end

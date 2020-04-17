require 'simplecov'
SimpleCov.start
require 'minitest/autorun'
require 'minitest/pride'
require './lib/encryption_algorithm'
require './lib/enigma'
require 'mocha/minitest'

require 'pry'

class EnigmaTest < Minitest::Test

  def test_it_exists
    enigma =  Enigma.new
    assert_instance_of Enigma, enigma
  end

  def test_it_encrypts_message
    enigma =  Enigma.new
  #   # binding.pry
    expected = {:encryption => "v rw", :key=>"12345", :date=>"130591"}
    assert_equal expected, enigma.encrypt("abcd", "12345", "130591")
    expected = {:encryption => "v rw!!!", :key=>"12345", :date=>"130591"}
    assert_equal expected, enigma.encrypt("abcd!!!", "12345", "130591")
    expected = {:encryption => "sbjv", :key=>"12345", :date=>"170420"}
    assert_equal expected, enigma.encrypt("abcd", "12345")
    assert_equal true, enigma.encrypt("abcd").is_a?(Hash)
    assert_equal true, enigma.encrypt("abcd")[:encryption].length == 4
    enigma.stubs(:a_shift).returns(1)
    enigma.stubs(:b_shift).returns(2)
    enigma.stubs(:c_shift).returns(3)
    enigma.stubs(:d_shift).returns(4)
    exp_encrypion = "ctr obisy?cwmghtzbgsh!ciof"
    exp_date = "170420"
    assert_equal exp_encrypion, enigma.encrypt("brown fox? sleepy dog! end")[:encryption]
    assert_equal exp_date, enigma.encrypt("brown fox? sleepy dog! end")[:date]
  end

  def test_it_decrypts_message
    enigma =  Enigma.new

    expected = {:decryption=>"abcd", :key=>"12345", :date=>"130591"}
    assert_equal expected, enigma.decrypt("v rw", "12345", "130591")
    expected = {:decryption=>"abcd", :key=>"12345", :date=>"170420"}
    assert_equal expected, enigma.decrypt("sbjv", "12345")

  end

  def test_it_writes_to_file
    enigma =  Enigma.new
    message = "Why walk when you can eat cake?"
    filepath = "./text/test_file.txt"

    enigma.write_to_file(message, filepath)

    expected = enigma.read_txt(filepath)[0]
    assert_equal expected, message.downcase
  end

  def test_user_input
    enigma =  Enigma.new
    enigma.stubs(:user_input).returns("snow storm")
    assert_equal "snow storm", enigma.original_filepath
    assert_equal "snow storm", enigma.encryption_filepath
  end

  def test_encryption_runner

    enigma =  Enigma.new
    message = "dog"
    # original_filepath = "./text/test_message.txt"
    # encrypted_filepath = "./text/test_encryption.txt"
    enigma.stubs(:original_filepath).returns("./text/test_message.txt")
    enigma.stubs(:encrypted_filepath).returns("./text/test_encrypted.txt")
    enigma.encryption_runner

    expected = enigma.read_txt("./text/test_encrypted.txt")[0]
    actual = enigma.encrypted_details[:encryption]
    assert_equal expected, enigma.encrypted_details[:encryption]
  end


end

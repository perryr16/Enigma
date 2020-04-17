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

  # def test_encrypt_runner_method
  #   enigma =  Enigma.new
  #
  #   enigma.encryption_runner
  # end

end

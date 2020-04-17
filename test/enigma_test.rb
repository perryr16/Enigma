require 'simplecov'
SimpleCov.start
require 'minitest/autorun'
require 'minitest/pride'
require './lib/encrypt'
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
    expected = {:encryption => "v rw", :key=>"12345", :date=>"130591"}
    assert_equal expected, enigma.encrypt("abcd", "12345", "130591")
    expected = {:encryption => "v rw!!!", :key=>"12345", :date=>"130591"}
    assert_equal expected, enigma.encrypt("abcd!!!", "12345", "130591")
    expected = {:encryption => "sbjv", :key=>"12345", :date=>"170420"}
    assert_equal expected, enigma.encrypt("abcd", "12345")
    assert_equal true, enigma.encrypt("abcd").is_a?(Hash)
    assert_equal true, enigma.encrypt("abcd")[:encryption].length == 4
    enigma.encrypter.stubs(:a_shift).returns(1)
    enigma.encrypter.stubs(:b_shift).returns(2)
    enigma.encrypter.stubs(:c_shift).returns(3)
    enigma.encrypter.stubs(:d_shift).returns(4)
    expected = {:encryption=>"ctr obisy?cwmghtzbgsh!ciof", :key=>nil, :date=>"170420"}
    assert_equal expected, enigma.encrypt("brown fox? sleepy dog! end")
  end

  def test_it_decrypts_message
    enigma =  Enigma.new
    
    expected = {:decryption=>"abcd", :key=>"12345", :date=>"130591"}
    assert_equal expected, enigma.decrypt("v rw", "12345", "130591")
    expected = {:decryption=>"abcd", :key=>"12345", :date=>"170420"}
    assert_equal expected, enigma.decrypt("sbjv", "12345")

  end

end

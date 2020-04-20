require 'simplecov'
SimpleCov.start
require 'minitest/autorun'
require 'minitest/pride'
require './lib/offset_gen'

require 'pry'

class OffsetGenTest < Minitest::Test


  def test_it_exists
    offset_gen = OffsetGen.new
    assert_instance_of OffsetGen, offset_gen

  end

  def test_date_returns_offsets
    offset_gen = OffsetGen.new

    date = "170420"
    assert_equal 6, offset_gen.offsets(date)[0]
    assert_equal 4, offset_gen.offsets(date)[1]
    assert_equal 0, offset_gen.offsets(date)[2]
    assert_equal 0, offset_gen.offsets(date)[3]
  end

end

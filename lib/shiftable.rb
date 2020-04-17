module Shiftable

  attr_reader :keys,
              :key,
              :offsets,
              :a_shift,
              :b_shift,
              :c_shift,
              :d_shift,
              :five_digit_key

  def initialize
  end

  def today
    Date.today.strftime("%d%m%y").to_i
  end

  def date_squared(date)
    (date.to_i ** 2).digits[0..3].reverse
  end

  def offsets(date_squared)
    a_offset = date_squared[0]
    b_offset = date_squared[1]
    c_offset = date_squared[2]
    d_offset = date_squared[3]
    @offsets = [a_offset, b_offset, c_offset, d_offset]
  end

  def five_digit
    five_digit = rand(99999)
    @five_digit_key = five_digit.to_s.rjust(5, "0")[-5..-1]
  end

  # def keys(number)
  #   a_key = number[0..1].to_i
  #   b_key = number[1..2].to_i
  #   c_key = number[2..3].to_i
  #   d_key = number[3..4].to_i
  #   [a_key, b_key, c_key, d_key]
  # end

  def shifts(number, date)
    # binding.pry
    offset = offsets(date_squared(date))
    @key = number if !number.nil?
    @key = five_digit if number.nil?
    @a_shift = key[0..1].to_i + offset[0]
    @b_shift = key[1..2].to_i + offset[1]
    @c_shift = key[2..3].to_i + offset[2]
    @d_shift = key[3..4].to_i + offset[3]
    # binding.pry
  end

end

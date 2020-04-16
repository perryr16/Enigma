class KeyDate

  attr_reader :a_key,
              :b_key,
              :c_key,
              :d_key,
              :a_offset,
              :b_offset,
              :c_offset,
              :d_offset
              
  def today
    Date.today.strftime("%d%m%y").to_i
  end

  def offsets
    offset = (today ** 2).digits[0..3].reverse
    @a_offset = offset[0]
    @b_offset = offset[1]
    @c_offset = offset[2]
    @d_offset = offset[3]
  end

  def five_digit
    five_digit = rand(99999)
    five_digit.to_s.rjust(5, "0")[-5..-1]
  end

  def keys
    @a_key = five_digit[0..1].to_i
    @b_key = five_digit[1..2].to_i
    @c_key = five_digit[2..3].to_i
    @d_key = five_digit[3..4].to_i
  end

end

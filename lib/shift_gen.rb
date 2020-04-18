class ShiftGen

  attr_reader :key,
              :a_shift,
              :b_shift,
              :c_shift,
              :d_shift

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
    [a_offset, b_offset, c_offset, d_offset]
  end

  def five_digit
    five_digit = rand(99999)
    five_digit.to_s.rjust(5, "0")[-5..-1]
  end


  def shifts(number, date)
    offset = offsets(date_squared(date))
    @key = number if !number.nil?
    @key = five_digit if number.nil?
    @a_shift = key[0..1].to_i + offset[0]
    @b_shift = key[1..2].to_i + offset[1]
    @c_shift = key[2..3].to_i + offset[2]
    @d_shift = key[3..4].to_i + offset[3]
  end

end

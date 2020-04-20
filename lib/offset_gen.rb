class OffsetGen

  def offsets(date)
    date_squared = (date.to_i ** 2).digits[0..3].reverse
    a_offset = date_squared[0]
    b_offset = date_squared[1]
    c_offset = date_squared[2]
    d_offset = date_squared[3]
    [a_offset, b_offset, c_offset, d_offset]
  end

end

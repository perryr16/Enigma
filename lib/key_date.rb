class KeyDate

  def today
    Date.today.strftime("%d%m%y").to_i
  end

  def five_digit
    five_digit = rand(99999)
    five_digit.to_s.rjust(5, "0")[-5..-1]
  end

  def a_key
    five_digit[0..1].to_i
  end

  def b_key
    five_digit[1..2]
  end

  def c_key
    five_digit[2..3]
  end

  def d_key
    five_digit[3..4]
  end

end

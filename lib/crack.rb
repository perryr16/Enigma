class Crack

  def initialize
    @alpha_num = AlphaNum.new
    # @shift_gen = ShiftGen.new
  end

  def delta_end(message)
    delta_end = {}
    delta_end[:space] = (@alpha_num.a_one[message[-4]] - 26) % 27
    delta_end[:e] = (@alpha_num.a_one[message[-3]] - 4) % 27
    delta_end[:n] = (@alpha_num.a_one[message[-2]] - 13) % 27
    delta_end[:d] = (@alpha_num.a_one[message[-1]] - 3) % 27
    delta_end
  end

  def crack_a_index(message)
    return -4 if message.length % 4 == 0
    return -3 if message.length % 4 == 1
    return -2 if message.length % 4 == 2
    return -1 if message.length % 4 == 3
  end

  def crack_indexes(message)
    a_index = crack_a_index
    b_index = (crack_a_index + 1) % 4
    c_index = (crack_a_index + 2) % 4
    d_index = (crack_a_index + 3) % 4
    [a_index, b_index, c_index, d_index]
  end

  def crack_shift(message)
    delta_end
    crack_a_shift =
    crack_b_shift
    crack_c_shift
    crack_d_shift
  end

end

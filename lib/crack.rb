class Crack

  def initialize
    @alpha_num = AlphaNum.new
    # @shift_gen = ShiftGen.new
  end

  # def delta_end(message)
  #   delta_end = {}
  #   delta_end[:space] = (@alpha_num.a_one[message[-4]] - 26) % 27
  #   delta_end[:e] = (@alpha_num.a_one[message[-3]] - 4) % 27
  #   delta_end[:n] = (@alpha_num.a_one[message[-2]] - 13) % 27
  #   delta_end[:d] = (@alpha_num.a_one[message[-1]] - 3) % 27
  #   delta_end
  # end

  # def crack_a_index(message)
  #   return -4 if message.length % 4 == 0
  #   return -3 if message.length % 4 == 1
  #   return -2 if message.length % 4 == 2
  #   return -1 if message.length % 4 == 3
  # end

  # def crack_indexes(message)
  #   a_index = (message.length % 4)
  #   b_index = (a_index + 3) % 4
  #   c_index = (a_index + 2) % 4
  #   d_index = (a_index + 1) % 4
  #   crack_indexes = [a_index, b_index, c_index, d_index]
  #   crack_indexes[crack_indexes.index(0)] =  4
  #   crack_indexes = crack_indexes.map {|val| val * -1}
  #   crack_indexes = {a: crack_indexes[0], b: crack_indexes[1], c: crack_indexes[2], d: crack_indexes[3]}
  # end

  def crack_shift(message)
    crack_shift = {a: 0, b: 0, c: 0, d: 0}
    a_index = (message.length % -4)
    a_index = -4 if a_index == 0
    if a_index == -4
      # space
      crack_shift[:a] = (@alpha_num.a_one[message[-4]] - 26) % 27
      # e
      crack_shift[:b] = (@alpha_num.a_one[message[-3]] - 4) % 27
      # n
      crack_shift[:c] = (@alpha_num.a_one[message[-2]] - 13) % 27
      # d
      crack_shift[:d] = (@alpha_num.a_one[message[-1]] - 3) % 27
    elsif a_index == -3
      crack_shift[:d] = (@alpha_num.a_one[message[-4]] - 26) % 27
      crack_shift[:a] = (@alpha_num.a_one[message[-3]] - 4) % 27
      crack_shift[:b] = (@alpha_num.a_one[message[-2]] - 13) % 27
      crack_shift[:c] = (@alpha_num.a_one[message[-1]] - 3) % 27
    elsif a_index == -2
      crack_shift[:c] = (@alpha_num.a_one[message[-4]] - 26) % 27
      crack_shift[:d] = (@alpha_num.a_one[message[-3]] - 4) % 27
      crack_shift[:a] = (@alpha_num.a_one[message[-2]] - 13) % 27
      crack_shift[:b] = (@alpha_num.a_one[message[-1]] - 3) % 27
    elsif a_index == -1
      crack_shift[:b] = (@alpha_num.a_one[message[-4]] - 26) % 27
      crack_shift[:c] = (@alpha_num.a_one[message[-3]] - 4) % 27
      crack_shift[:d] = (@alpha_num.a_one[message[-2]] - 13) % 27
      crack_shift[:a] = (@alpha_num.a_one[message[-1]] - 3) % 27
    end
    crack_shift
  end

end

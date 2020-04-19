class Crack

  attr_reader :crack_shifts
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

  def crack_shift(message)
    delta = delta_end(message)
    a_index = (message.length % 4)
    a_index = 4 if a_index == 0
    crack_keys = [:a, :b, :c, :d].rotate(a_index)
    crack_vals = [delta[:space], delta[:e], delta[:n], delta[:d]]
    @crack_shifts = Hash[crack_keys.zip(crack_vals)]
  end

end

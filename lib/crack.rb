class Crack

  attr_reader :cracked_key
  def initialize
    @alpha_num = AlphaNum.new
    @shift_gen = ShiftGen.new
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
    Hash[crack_keys.zip(crack_vals)]
  end

  # def crack_key(message, date)
  #   offset = @shift_gen.offsets(date)
  #   crack_a_key = (crack_shift(message)[:a] - offset[0]) #12
  #   crack_b_key = (crack_shift(message)[:b] - offset[1]) + 27 #23
  #   crack_c_key = (crack_shift(message)[:c] - offset[2]) + 27 #34
  #   crack_d_key = (crack_shift(message)[:d] - offset[3]) + 27 #45
  #   @key = crack_a_key.to_s[0]+crack_b_key.to_s[0]+crack_c_key.to_s[0]+crack_d_key.to_s.rjust(2, "0")
  #   binding.pry
  # end
  #
  # def crack_key_new(message, date)
  #   offset = @shift_gen.offsets(date)
  #   crack_a_key = (crack_shift(message)[:a] - offset[0]) #12
  #   crack_b_key = all_possible_keys(message, date, :b, 1).find {}
  # end

  def all_possible_keys(message, date, letter_sym, offset_position)
    offset = @shift_gen.offsets(date)
    possible_keys = []
    index = 0
    loop do
      possible_key = (crack_shift(message)[letter_sym] - offset[offset_position]) + 27*index  #23
      break if possible_key > 99
      possible_keys << possible_key.to_s.rjust(2, "0") if possible_key > 0
      index += 1
    end
    possible_keys
  end

  def the_key(message, date, letter_sym, offset_position, first_digit)
    all_possible_keys(message, date, letter_sym, offset_position).find do |key|
      key[0] == first_digit
    end.to_s
  end

  def a_keys(message, date)
    all_possible_keys(message, date, :a, 0)
  end

  def four_good_keys(message, date)
    the_keys = []
    a_keys(message, date).each_with_index do |key|
      the_keys = [key.to_s]
      # binding.pry
      the_keys << the_key(message, date, :b, 1, key.to_s[1])
      # binding.pry
      the_keys << the_key(message, date, :c, 2, the_keys.last[1])
      # binding.pry
      the_keys << the_key(message, date, :d, 3, the_keys.last[1])
      return the_keys if !the_keys.include?("")
    end
    the_keys
  end

  def cracked_key(message, date)
    four_keys = four_good_keys(message, date)
    @cracked_key = four_keys[0][0] + four_keys[1][0] + four_keys[2][0] + four_keys[3]
  end

end

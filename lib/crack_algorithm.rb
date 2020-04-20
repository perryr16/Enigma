require './lib/alpha_numable'
class CrackAlgorithm

  include AlphaNumable

  attr_reader :cracked_key
  def initialize
  end

  def delta_end(message)
    message = message[0] if message.is_a?(Array)
    delta_end = {}
    delta_end[:space] = (alpha_to_num[message[-4]] - 26) % 27
    delta_end[:e] = (alpha_to_num[message[-3]] - 4) % 27
    delta_end[:n] = (alpha_to_num[message[-2]] - 13) % 27
    delta_end[:d] = (alpha_to_num[message[-1]] - 3) % 27
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

  def offsets(date)
    date_squared = (date.to_i ** 2).digits[0..3].reverse
    a_offset = date_squared[0]
    b_offset = date_squared[1]
    c_offset = date_squared[2]
    d_offset = date_squared[3]
    [a_offset, b_offset, c_offset, d_offset]
  end

  def all_possible_keys(message, date, letter_sym, offset_position)
    offset = offsets(date)
    possible_keys = []; index = 0
    loop do
      possible_key = (crack_shift(message)[letter_sym] - offset[offset_position]) + 27 * index
      break if possible_key > 99
      possible_keys << possible_key.to_s.rjust(2, "0") if possible_key > 0
      index += 1
    end
    possible_keys
  end

  def a_keys(message, date)
    all_possible_keys(message, date, :a, 0)
  end

  def the_key(message, date, letter_sym, offset_position, first_digit)
    all_possible_keys(message, date, letter_sym, offset_position).find do |key|
      key[0] == first_digit
    end.to_s
  end


  def four_good_keys(message, date)
    the_keys = []
    a_keys(message, date).each_with_index do |key|
      the_keys = [key.to_s]
      the_keys << the_key(message, date, :b, 1, key.to_s[1])
      the_keys << the_key(message, date, :c, 2, the_keys.last[1])
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

require './lib/alpha_numable'
require './lib/shift_gen'
require './lib/crack_algorithm'
class EncryptionAlgorithm

  include AlphaNumable

  attr_reader :message, :alpha_num, :shift_gen, :crack
  def initialize
    @message = []
    couple
  end

  def couple
    # @alpha_num = AlphaNum.new
    @shift_gen = ShiftGen.new
    @crack = Crack.new
  end

  def split_characters(message)
    message = message.join(" ") if message.is_a?(Array)
    message.split("")
  end

  def to_numeric(message)
    split_characters(message).map do |letter|
      if !a_one[letter].nil?
         a_one[letter]
      else
        letter
      end
    end
  end

  def split_4th(message)
    a_code = []; b_code = []; c_code = []; d_code = []
    to_numeric(message).each_with_index do |character, index|
      a_code << character if index % 4 == 0
      b_code << character if index % 4 == 1
      c_code << character if index % 4 == 2
      d_code << character if index % 4 == 3
    end
    [a_code, b_code, c_code, d_code]
  end

   def shift(code, shift, multiplier = 1)
     shift *= multiplier
     code.map do |number|
      if number.is_a?(Integer)
        ( number + shift % 27) % 27
      else
         number
      end
    end
   end

   def zip_together(message, a_shift, b_shift, c_shift, d_shift, multiplier = 1)
     one_code = shift(split_4th(message)[0], a_shift, multiplier)
     two_code = shift(split_4th(message)[1], b_shift, multiplier)
     three_code = shift(split_4th(message)[2], c_shift, multiplier)
     four_code = shift(split_4th(message)[3], d_shift, multiplier)
     one_code.zip(two_code, three_code, four_code).flatten.compact
   end

  def to_alpha(numbers)
    numbers.map do |num|
      if !one_a[num].nil?
         one_a[num]
      else
        num
      end
    end.join
  end

end

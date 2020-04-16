require 'date'
class Encrypt

  attr_reader :message
  def initialize
    @message = []
  end

  def read_txt
    filename = "./text/secret_message.txt"
    File.open(filename).each {|line| @message << line.downcase}
    @message.map {|line| line.slice!("\n")}
  end

  def split_characters
    @message.join(" ").split("")
  end

  def a_one
    alpha = ("a".."z").to_a << " "
    numeric = (0..26).to_a
    Hash[alpha.zip(numeric)]
  end

  def one_a
    numeric = (0..26).to_a
    alpha = ("a".."z").to_a << " "
    Hash[numeric.zip(alpha)]
  end

  def to_numeric
    split_characters.map do |letter|
      if !a_one[letter].nil?
         a_one[letter]
      else
        letter
      end
    end
  end

  def split_4th
    a_code = []; b_code = []; c_code = []; d_code = []
    split_characters.each_with_index do |character, index|
      a_code << character if index % 4 == 0
      b_code << character if index % 4 == 1
      c_code << character if index % 4 == 2
      d_code << character if index % 4 == 3
    end
    [a_code, b_code, c_code, d_code]
  end

  def split_4th
    a_code = []; b_code = []; c_code = []; d_code = []
    to_numeric.each_with_index do |character, index|
      a_code << character if index % 4 == 0
      b_code << character if index % 4 == 1
      c_code << character if index % 4 == 2
      d_code << character if index % 4 == 3
    end
    [a_code, b_code, c_code, d_code]
  end

   def shift(code, key)
     code.map do |number|
      if number.is_a?(Integer)
        ( number + key % 27) % 27
      else
         number
      end
    end
   end

   def zip_together
     one_code = shift(split_4th[0], 1)
     two_code = shift(split_4th[1], 2)
     three_code = shift(split_4th[2], 3)
     four_code = shift(split_4th[3], 4)
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

  def today
    Date.today.strftime("%d%m%y").to_i
  end

  def encrypt(message, key, date = today)
    binding.pry
  end

end

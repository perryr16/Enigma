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

  def a1_z26
    alpha = ("a".."z").to_a << " "
    numeric = (1..27).to_a
    Hash[alpha.zip(numeric)]
  end

  def to_numeric
    split_characters.map do |letter|
      if !a1_z26[letter].nil?
         a1_z26[letter]
      else
        letter
      end
    end
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

    binding.pry
  end


  def zip_together
    split_4th[0].zip(split_4th[1], split_4th[2], split_4th[3]).join
  end



end

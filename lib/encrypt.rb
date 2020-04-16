class Encrypt

  attr_reader :message, :a_code, :b_code, :c_code, :d_code
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



  def split_4th_index
    @a_code = []; @b_code = []; @c_code = []; @d_code = []
    split_characters.each_with_index do |character, index|
      @a_code << character if index % 4 == 0
      @b_code << character if index % 4 == 1
      @c_code << character if index % 4 == 2
      @d_code << character if index % 4 == 3
    end
  end



end

class Encrypt

  attr_reader :message
  def initialize
    @message = []
  end

  def read_txt
    filename = "./text/secret_message.txt"
    File.open(filename).each {|line| @message << line}
    @message.map {|line| line.slice!("\n")}
  end

  def split_characters
    @message.join(" ").split("")
  end



end

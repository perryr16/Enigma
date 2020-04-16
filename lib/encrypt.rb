class Encrypt

  def initialize
    @message = []
  end

  def read_txt
    filename = "./text/secret_message.txt"
    File.open(filename).each do |line|
      @message << line
    end
    @message
  end



end

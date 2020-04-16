class Enigma


  def initialize
    @encrypter = Encrypt.new
  end

  def encrypt

    @encrypter.read_txt
      binding.pry
  end
end

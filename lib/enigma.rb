class Enigma

  attr_reader :encrypter
  def initialize
    @encrypter = Encrypt.new
  end

  def encrypt(message, key = nil, date = @encrypter.today)
    @encrypter.encrypt(message, key, date)
  end

  def decrypt(message, key = nil, date = @encrypter.today)
    @encrypter.decrypt(message, key, date)
  end
end

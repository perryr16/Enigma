require_relative 'encryption_algorithm'

class Enigma < EncryptionAlgorithm

  attr_reader :message
  def initialize
    @message = []
  end

  def read_txt(filename)
    # filename = "./text/secret_message.txt"
    File.open(filename).each {|line| @message << line.downcase}
    @message.map do |line|
      line.sub("\n", "")
    end
  end

  def user_input
    input = gets.chomp
  end


  def encrypt(message, enc_key = nil, date = today)
    shifts(enc_key, date)
    numbers = zip_together(message, a_shift, b_shift, c_shift, d_shift)
    encrypted = to_alpha(numbers)
    {encryption: encrypted, key: key, date: date.to_s}

  end

  def decrypt(code, key = nil, date = today)
      shifts(key, date)
      to_numeric(code)
      split_4th(code)
      numbers = de_zip_together(code, a_shift, b_shift, c_shift, d_shift)
      decrypted = to_alpha(numbers)
      {decryption: decrypted, key: key, date: date.to_s}
  end

  # def encryption_runner
  #   puts "Enter filename with message to encrypt"
  #   filename = user_input
  #   message = read_txt(filename)
  #   pry
  #   encryped_details = encrypt(message)
  #   puts "#{encrypt(message)[:encryption]} with the key #{encrypt(message)[:key]} and date #{encrypt(message)[:date]}"
  # end


end

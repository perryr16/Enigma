require_relative 'encryption_algorithm'

class Enigma < EncryptionAlgorithm

  attr_reader :message, :encrypted_details
  def initialize

  end

  def read_txt(filename)
    # filename = "./text/secret_message.txt"
    @message = []
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

  def write_to_file(message, filepath)
    file = File.open(filepath, "w")
    file.write(message)
    file.close
  end

  def original_filepath
    user_input
  end

  def encryption_filepath
    user_input
  end

  def encryption_runner
    puts "Enter filename with message to encrypt"
    original_filepath
    puts "Enter filename to store the enctyped message"
    encrypted_filepath

    message = read_txt(original_filepath)
    @encrypted_details = encrypt(message)
    puts "#{@encrypted_details[:encryption]} with the key #{@encrypted_details[:key]} and date #{@encrypted_details[:date]}"

    write_to_file(@encrypted_details[:encryption], encrypted_filepath)
  end




end

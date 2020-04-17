require_relative 'encryption_algorithm'

class Enigma < EncryptionAlgorithm

  attr_reader :message, :encrypted_details, :decrypted_details
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

  def original_input
    user_input
  end

  def encrypted_input
    user_input
  end

  def encryption_runner
    puts "Enter filename with message to encrypt"
    message_file = original_input
    puts "Enter filename to store the enctyped message"
    encrypted_file = encrypted_input

    message = read_txt(message_file)

    @encrypted_details = encrypt(message)

    puts "#{@encrypted_details[:encryption]} with the key #{@encrypted_details[:key]} and date #{@encrypted_details[:date]}"

    write_to_file(@encrypted_details[:encryption], encrypted_file)
  end

  def decryption_runner
    puts "Enter filename with message to decrypt"
    encrypted_file = original_input
    puts "Enter filename to store the dectyped message"
    decrypted_file = encrypted_input
    puts "Enter decryption key"
    de_key = user_input
    puts "Enter date"
    de_date = user_input

    message = read_txt(encrypted_file)
    @decrypted_details = decrypt(message, de_key, de_date)
    puts "#{@decrypted_details[:decryption]} with the key #{@decrypted_details[:key]} and date #{@decrypted_details[:date]}"

    write_to_file(@encrypted_details[:decryption], decrypted_file)
  end




end

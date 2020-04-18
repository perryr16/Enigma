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

  def encryption_runner

    puts "Enter: secret message path, encrypted message path"
    input = user_input

    input = input.split(" ")
    message_file = input[0]
    encrypted_file = input[1]
    message = read_txt(message_file)

    @encrypted_details = encrypt(message)
    puts "-------------"
    puts "#{@encrypted_details[:encryption]} with the key #{@encrypted_details[:key]} and date #{@encrypted_details[:date]}"
    puts "-------------"

    write_to_file(@encrypted_details[:encryption], encrypted_file)
  end

  def decryption_runner

    puts "Enter: encrypted message path, decrypted message path, key, date"
    input = user_input
    input = input.split(" ")
    encrypted_file = input[0]
    decrypted_file = input[1]
    de_key = input[2]
    de_date = input[3]


    message = read_txt(encrypted_file)
    @decrypted_details = decrypt(message, de_key, de_date)
    puts "-------------"
    puts "#{@decrypted_details[:decryption]} with the key #{@decrypted_details[:key]} and date #{@decrypted_details[:date]}"
    puts "-------------"
    write_to_file(@decrypted_details[:decryption], decrypted_file)
  end




end

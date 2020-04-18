
require 'pry'
require_relative 'encryption_algorithm'

class Enigma < EncryptionAlgorithm

  attr_reader :message, :encrypted_details, :decrypted_details
  def initialize
    couple
  end

  def read_txt(filename)
    # filename = "./text/secret_message.txt"
    @message = []
    File.open(filename).each {|line| @message << line.downcase}
    @message.map do |line|
      line.sub("\n", "")
    end
  end

  def encrypt(message, enc_key = nil, date = @shift_gen.today)
    @shift_gen.shifts(enc_key, date)
    numbers = zip_together(message, @shift_gen.a_shift, @shift_gen.b_shift, @shift_gen.c_shift, @shift_gen.d_shift)
    encrypted = to_alpha(numbers)
    {encryption: encrypted, key: @shift_gen.key, date: date.to_s}
  end

  def decrypt(code, key = nil, date = @shift_gen.today)
      @shift_gen.shifts(key, date)
      to_numeric(code)
      split_4th(code)
      numbers = de_zip_together(code, @shift_gen.a_shift, @shift_gen.b_shift, @shift_gen.c_shift, @shift_gen.d_shift)
      decrypted = to_alpha(numbers)
      {decryption: decrypted, key: key, date: date.to_s}
  end

  def write_to_file(message, filepath)
    file = File.open(filepath, "w")
    file.write(message)
    file.close
  end

  def user_input
    input = ARGV
  end

  def encryption_runner
    input = user_input
    message_file = input[0]
    encrypted_file = input[1]
    message = read_txt(message_file)

    @encrypted_details = encrypt(message)
    puts "-------------"
    puts "#{encrypted_file} with the key #{@encrypted_details[:key]} and date #{@encrypted_details[:date]}"
    puts "-------------"
    write_to_file(@encrypted_details[:encryption], encrypted_file)
  end

  def decryption_runner
    input = user_input
    encrypted_file = input[0]
    decrypted_file = input[1]
    de_key = input[2]
    de_date = input[3]


    message = read_txt(encrypted_file)
    @decrypted_details = decrypt(message, de_key, de_date)
    puts "-------------"
    puts "#{decrypted_file} with the key #{@decrypted_details[:key]} and date #{@decrypted_details[:date]}"
    puts "-------------"
    write_to_file(@decrypted_details[:decryption], decrypted_file)
  end

end

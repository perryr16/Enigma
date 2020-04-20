require 'pry'
# require_relative 'encryption_algorithm'

class Enigma #< EncryptionAlgorithm

  attr_reader :message,
              :encrypted_details,
              :decrypted_details,
              :cracked_details,
              :shift_gen

  def initialize
    @shift_gen = ShiftGen.new
    @crack = CrackAlgorithm.new
    @encrypt = EncryptionAlgorithm.new
  end

  def read_txt(filename)
    @message = []
    File.open(filename).each {|line| @message << line.downcase}
    @message.map do |line|
      line.sub("\n", "")
    end
  end

  def write_to_file(message, filepath)
    file = File.open(filepath, "w")
    file.write(message)
    file.close
  end

  def user_input
    ARGV
  end

  def encrypt(message, enc_key = nil, date = @shift_gen.today)
    @shift_gen.shifts(enc_key, date)
    numbers = @encrypt.zip_together(message, @shift_gen.a_shift, @shift_gen.b_shift, @shift_gen.c_shift, @shift_gen.d_shift)
    encrypted = @encrypt.to_alpha(numbers)
    {encryption: encrypted, key: @shift_gen.key, date: date.to_s}
  end

  def decrypt(code, key = nil, date = @shift_gen.today)
    @shift_gen.shifts(key, date)
    @encrypt.to_numeric(code)
    @encrypt.split_4th(code)
    numbers = @encrypt.zip_together(code, @shift_gen.a_shift, @shift_gen.b_shift, @shift_gen.c_shift, @shift_gen.d_shift, -1)
    decrypted = @encrypt.to_alpha(numbers)
    {decryption: decrypted, key: key, date: date.to_s}
  end

  def crack(code, date = @shift_gen.today)
    cracked_key = @crack.cracked_key(code, date)
    @shift_gen.shifts(cracked_key, date)
    @encrypt.to_numeric(code)
    @encrypt.split_4th(code)
    numbers = @encrypt.zip_together(code, @shift_gen.a_shift, @shift_gen.b_shift, @shift_gen.c_shift, @shift_gen.d_shift, -1)
    decrypted = @encrypt.to_alpha(numbers)
    {decryption: decrypted, key: cracked_key, date: date.to_s}
  end

  def encryption_runner
    input = user_input
    message_file = input[0]
    encrypted_file = input[1]
    message = read_txt(message_file)
    @encrypted_details = encrypt(message)
    # puts "#{encrypted_file} with the key #{@encrypted_details[:key]} and date #{@encrypted_details[:date]}"
    puts "#{@encrypted_details[:encryption]} with the key #{@encrypted_details[:key]} and date #{@encrypted_details[:date]}"
    write_to_file(@encrypted_details[:encryption], encrypted_file)
  end

  def decryption_runner
    input = user_input
    encrypted_file = input[0]
    decrypted_file = input[1]
    de_key = input[2]; de_date = input[3]
    message = read_txt(encrypted_file)
    @decrypted_details = decrypt(message, de_key, de_date)
    # puts "#{decrypted_file} with the key #{@decrypted_details[:key]} and date #{@decrypted_details[:date]}"
    puts "#{@decrypted_details[:decryption]} with the key #{@decrypted_details[:key]} and date #{@decrypted_details[:date]}"
    write_to_file(@decrypted_details[:decryption], decrypted_file)
  end

  def crack_runner
    input = user_input
    encrypted_file = input[0]
    cracked_file = input[1]
    crack_date = input[2]
    message = read_txt(encrypted_file)
    @cracked_details = crack(message[0], crack_date)
    # puts "#{cracked_file} with the key #{@cracked_details[:key]} and date #{@cracked_details[:date]}"
    puts "#{@cracked_details[:decryption]} with the key #{@cracked_details[:key]} and date #{@cracked_details[:date]}"
    write_to_file(@cracked_details[:decryption], cracked_file)
  end

end

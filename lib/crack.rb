require 'date'
require './lib/encryption_algorithm'
require './lib/crack_algorithm'
require './lib/shift_gen'
require './lib/enigma'
enigma = Enigma.new

enigma.crack_runner

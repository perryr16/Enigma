require './lib/enigma'
require 'date'
require './lib/shift_gen'
require './lib/crack_algorithm'
enigma = Enigma.new

enigma.crack_runner

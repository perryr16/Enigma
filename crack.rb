require './lib/enigma'
require 'date'
require './lib/shift_gen'
require './lib/alpha_num'
require './lib/crack'
enigma = Enigma.new

enigma.crack_runner

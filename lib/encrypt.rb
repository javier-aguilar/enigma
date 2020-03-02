require 'date'
require './lib/enigma'

enigma = Enigma.new()

source_file_path = ARGV[0]
output_file_path = ARGV[1]
ARGV[2].nil? ? key = enigma.randomize_five_digits : key = ARGV[2]
ARGV[3].nil? ? date = enigma.current_date : date = ARGV[3]

file = File.open(source_file_path)
text = file.read

encryption = enigma.encrypt(text, key, date)
File.write(output_file_path, encryption[:encryption])

puts "Created #{output_file_path} with the key #{encryption[:key]} and date #{encryption[:date]}"

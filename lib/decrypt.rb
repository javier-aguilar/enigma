require 'date'
require './lib/enigma'

enigma = Enigma.new()

source_file_path = ARGV[0]
output_file_path = ARGV[1]
key = ARGV[2]
date = ARGV[3]

file = File.open(source_file_path)
text = file.read

decryption = enigma.decrypt(text, key, date)
File.write(output_file_path, decryption[:decryption])

puts "Created #{output_file_path} with the key #{decryption[:key]} and date #{decryption[:date]}"

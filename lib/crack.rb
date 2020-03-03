require './lib/enigma'

enigma = Enigma.new()

def error(message)
  puts "Please provide #{message}"
  exit
end

ARGV[0].nil? ? (error("encrypted source")) : encrypted_source = ARGV[0]
ARGV[1].nil? ? (error("destination source")) : output_file_path = ARGV[1]
ARGV[2].nil? ? (error("date")) : date = ARGV[2]

file = File.open(encrypted_source)
ciphertext = file.read

decryption = enigma.crack(ciphertext, date)
File.write(output_file_path, decryption[:decryption])

puts "Created #{output_file_path} with the key #{decryption[:key]} "\
     "and date #{decryption[:date]}"

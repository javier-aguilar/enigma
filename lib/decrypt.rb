require './lib/enigma'

enigma = Enigma.new()

def error(message)
  puts "Please provide #{message}"
  exit
end

ARGV[0].nil? ? (error("input source")) : source_file_path = ARGV[0]
ARGV[1].nil? ? (error("destination source")) : output_file_path = ARGV[1]
ARGV[2].nil? ? (error("key")) : key = ARGV[2]
ARGV[3].nil? ? (error("date")) : date = ARGV[3]

file = File.open(source_file_path)
ciphertext = file.read

decryption = enigma.decrypt(ciphertext, key, date)
File.write(output_file_path, decryption[:decryption])

puts "Created #{output_file_path} with the key #{decryption[:key]} "\
     "and date #{decryption[:date]}"

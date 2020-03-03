require 'date'
require './lib/crackable'
require './lib/computable'

class Enigma
  include Crackable
  include Computable

  def initialize()
    @character_set = ("a".."z").to_a << " "
    @current_date = current_date
  end

  def generate_keys(number)
    { A: number[0..1], B: number[1..2], C: number[2..3], D: number[3..4] }
  end

  def generate_offsets(date)
    offsets = square_date(date).slice(-4, 4)
    { A: offsets[0], B: offsets[1], C: offsets[2], D: offsets[3] }
  end

  def generate_shifts(key, date)
    keys = generate_keys(key)
    offsets = generate_offsets(date)
    { A: keys[:A].to_i + offsets[:A].to_i,
      B: keys[:B].to_i + offsets[:B].to_i,
      C: keys[:C].to_i + offsets[:C].to_i,
      D: keys[:D].to_i + offsets[:D].to_i }
  end

  def character_rotate(character, shift)
    original_position = @character_set.find_index(character)
    @character_set.rotate(shift)[original_position]
  end

  def shift_character(character, shift, index)
    if !@character_set.include? character
      return character
    else
      return character_rotate(character, shift[:A]) if index % 4 == 1
      return character_rotate(character, shift[:B]) if index % 4 == 2
      return character_rotate(character, shift[:C]) if index % 4 == 3
      return character_rotate(character, shift[:D]) if index % 4 == 0
    end
  end

  def message_writer(message, shift)
    new_message = ""
    lowercase_message = message.downcase
    lowercase_message.each_char.with_index(1) do | character, index |
      new_message << shift_character(character, shift, index)
    end
    new_message
  end

  def transcode(message, key, date, decrypt = false )
    shift = generate_shifts(key, date)
    shift.each { |key, shift_num| shift[key] = -shift_num } if decrypt
    message_writer(message, shift)
  end

  def encrypt(message, key = randomize_five_digits, date = @current_date)
    encrypted_message = transcode(message, key, date)
    { encryption: encrypted_message, key: key, date: date }
  end

  def decrypt(ciphertext, key, date = @current_date)
    decrypted_message = transcode(ciphertext, key, date, true)
    { decryption: decrypted_message, key: key, date: date }
  end

  def crack(ciphertext, date = @current_date)
    offset = generate_offsets(date)
    last_characters = last_four_characters_positions(ciphertext)
    expected_end = expected_message_end(ciphertext)
    shift = crack_shifts(last_characters, expected_end)
    keys = crack_keys(shift, offset)

    decrypt = decrypt(ciphertext, combine_keys(keys), date)
    { decryption: decrypt[:decryption], date: date, key: combine_keys(keys) }
  end

end

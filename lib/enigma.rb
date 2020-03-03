require 'date'

class Enigma

  def initialize()
    @character_set = ("a".."z").to_a << " "
    @current_date = current_date
  end

  def current_date
    Date.today.strftime "%d%m%y"
  end

  def randomize_five_digits
    rand(0..99999).to_s.rjust(5, "0")
  end

  def square_date(date)
    (date.to_i ** 2).to_s
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
    {
      A: keys[:A].to_i + offsets[:A].to_i,
      B: keys[:B].to_i + offsets[:B].to_i,
      C: keys[:C].to_i + offsets[:C].to_i,
      D: keys[:D].to_i + offsets[:D].to_i
    }
  end

  def character_rotate(character, shift)
    original_position = @character_set.find_index(character)
    @character_set.rotate(shift)[original_position]
  end

  def write_character(character, shift, index)
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
      new_message << write_character(character, shift, index)
    end
    new_message
  end

  def cipher(message, key, date, decrypt = false )
    shift = generate_shifts(key, date)
    shift.each { |key, shift_num| shift[key] = -shift_num } if decrypt
    message_writer(message, shift)
  end

  def encrypt(message, key = randomize_five_digits, date = @current_date)
    encrypted_message = cipher(message, key, date)
    { encryption: encrypted_message, key: key, date: date }
  end

  def decrypt(ciphertext, key, date = @current_date)
    decrypted_message = cipher(ciphertext, key, date, true)
    { decryption: decrypted_message, key: key, date: date }
  end

  def crack(ciphertext, date = @current_date)
    offsets = generate_offsets(date)

    last_four_characters = ciphertext.slice(-4, 4)
    position = ciphertext.size - 4
    four = []
    last_four_characters.each_char.with_index(position) do | character, index |
      four[index % 4] = character
    end

    expected = ""
    expected = " end" if ciphertext.size % 4 == 0
    expected = "d ne" if ciphertext.size % 4 == 1
    expected = "nd e" if ciphertext.size % 4 == 2
    expected = "end " if ciphertext.size % 4 == 3

    shifts = []
    4.times.with_index do |index|
      shifts << ((27 - @character_set.find_index(four[index])) + (@character_set.find_index(expected[index])))
    end
    
    sum = []
    total = 0
    offsets.each.with_index do | (key, _), index |
      total = -shifts[index] - offsets[key].to_i
      while(total < 0)
        total += 27
      end
      while(index != 0 && sum[index - 1].to_s[1] != total.to_s.rjust(2, "0")[0])
        total += 27
      end
      sum << total.to_s.rjust(2, "0")
    end

    key = "#{sum[0].to_s}#{sum[1].to_s[-1]}#{sum[2].to_s[-1]}#{sum[3].to_s[-1]}"
    info = decrypt(ciphertext, key, date)
    { decryption: info[:decryption], date: date, key: key}
  end

end

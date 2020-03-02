class Enigma

  def initialize()
    @alphabet = ("a".."z").to_a << " "
    @current_date = DateTime.now.strftime "%d%m%y"
  end

  def randomize_five_digits
    rand(0..99999).to_s.rjust(5, "0")
  end

  def square_date(date)
    (date.to_i ** 2).to_s
  end

  def generate_keys(num)
    { A: num[0..1], B: num[1..2], C: num[2..3], D: num[3..4] }
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
    original_position = @alphabet.find_index(character)
    @alphabet.rotate(shift)[original_position]
  end

  def write_character(character, shift, index)
    if !@alphabet.include? character
      return character
    else
      return character_rotate(character, shift.fetch(:A)) if index % 4 == 1
      return character_rotate(character, shift.fetch(:B)) if index % 4 == 2
      return character_rotate(character, shift.fetch(:C)) if index % 4 == 3
      return character_rotate(character, shift.fetch(:D)) if index % 4 == 0
    end
  end

  def message_writer(message, shift)
    new_message = ""
    message.downcase.each_char.with_index(1) do | character, index |
      new_message << write_character(character, shift, index)
    end
    new_message
  end

  def cipher(message, key, date, decrypt = false )
    shift = generate_shifts(key, date)
    shift.each { |key, value| shift[key] = -value } if decrypt
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

end

class Enigma

  def initialize()
    @alphabet = ("a".."z").to_a << " "
    @current_date = DateTime.now.strftime "%d%m%y"
  end

  def randomize_five_digits
    rand(0..99999).to_s.rjust(5, "0")
  end

  def generate_keys(five_digit_num)
    {
      A: five_digit_num[0..1],
      B: five_digit_num[1..2],
      C: five_digit_num[2..3],
      D: five_digit_num[3..4]
    }
  end

  def generate_offsets(date)
    squared_date = (date.to_i * date.to_i)
    offsets = squared_date.to_s.slice(-4, 4)
    {
      A: offsets[0],
      B: offsets[1],
      C: offsets[2],
      D: offsets[3]
    }
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

  def cipher(message, key, date, decrypt = false)
    shift = generate_shifts(key, date)
    shift.each { |key, value| shift[key] = -value } if decrypt == true

    new_message = ""
    message.downcase.each_char.with_index(1) do | character, index |
      original_position = @alphabet.find_index(character)
      if !@alphabet.include? character
        new_message << character
      elsif index % 4 == 1
        new_message << @alphabet.rotate(shift.fetch(:A))[original_position]
      elsif index % 4 == 2
        new_message << @alphabet.rotate(shift.fetch(:B))[original_position]
      elsif index % 4 == 3
        new_message << @alphabet.rotate(shift.fetch(:C))[original_position]
      elsif index % 4 == 0
        new_message << @alphabet.rotate(shift.fetch(:D))[original_position]
      end
    end
    new_message
  end

  def encrypt(message, key = randomize_five_digits, date = @current_date)
    encrypted_message = cipher(message, key, date)
    { encryption: encrypted_message, key: key, date: date }
  end

  def decrypt(message, key, date = @current_date)
    decrypted_message = cipher(message, key, date, true)
    { decryption: decrypted_message, key: key, date: date }
  end

end

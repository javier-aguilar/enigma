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

  def encrypt(message, key = randomize_five_digits, date = @current_date)
    shift = generate_shifts(key, date)
    encrypted_message = ""
    message.downcase.each_char.with_index(1) do | character, index |
      original_position = @alphabet.find_index(character)
      if !@alphabet.include? character
        encrypted_message << character
      elsif index % 4 == 1
        encrypted_message << @alphabet.rotate(shift[:A])[original_position]
      elsif index % 4 == 2
        encrypted_message << @alphabet.rotate(shift[:B])[original_position]
      elsif index % 4 == 3
        encrypted_message << @alphabet.rotate(shift[:C])[original_position]
      elsif index % 4 == 0
        encrypted_message << @alphabet.rotate(shift[:D])[original_position]
      end
    end
    {
      encryption: encrypted_message,
      key: key,
      date: date
    }
  end

end

module Crackable

  def last_four_characters_positions(ciphertext)
    last_four_characters = ciphertext.slice(-4, 4)
    position = ciphertext.size - 4
    last_four_positions = []
    last_four_characters.each_char.with_index(position) do | character, index |
      last_four_positions[index % 4] = character
    end
    last_four_positions
  end

  def expected_message_end(ciphertext)
    return " end" if ciphertext.size % 4 == 0
    return "d en" if ciphertext.size % 4 == 1
    return "nd e" if ciphertext.size % 4 == 2
    return "end " if ciphertext.size % 4 == 3
  end

  def crack_shifts(last_chars, expected_end)
    shifts = []
    4.times.with_index do |index|
      encrypt_char_position = @character_set.find_index(last_chars[index])
      decrypt_char_position = @character_set.find_index(expected_end[index])
      shifts << (27 - encrypt_char_position) + (decrypt_char_position)
    end
    shifts
  end

  def crack_keys(shift, offset)
    keys = []
    total = 0
    offset.each.with_index do | (key, _), index |
      total = -shift[index] - offset[key].to_i
      total += 27 while total < 0
      total += 27 while index != 0 && !keys_match?(keys, total, index)
      keys << total.to_s.rjust(2, "0")
    end
    keys
  end

  def keys_match?(keys, total, index)
    keys[index-1].to_s[1] == total.to_s.rjust(2, "0")[0]
  end

  def combine_keys(keys)
    "#{keys[0]}#{keys[1][-1]}#{keys[2][-1]}#{keys[3][-1]}"
  end

end

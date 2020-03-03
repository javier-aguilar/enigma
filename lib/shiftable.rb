module Shiftable

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
  
end
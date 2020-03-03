require './test/test_helper'
require './lib/enigma'

class ShiftableTest < Minitest::Test

  def setup
    @enigma = Enigma.new()
    @current_date = DateTime.now.strftime "%d%m%y"
  end

  def test_it_rotate_character
    expected = "c"
    assert_equal expected, @enigma.character_rotate("a", 2)
    expected = " "
    assert_equal expected, @enigma.character_rotate("b", -2)
  end

  def test_it_can_determine_shift_for_character
    shift = {A: 1, B: 2, C: 3, D: 4}
    assert_equal "!", @enigma.shift_character("!", shift, 0)
    assert_equal "g", @enigma.shift_character("c", shift, 0)
    assert_equal "d", @enigma.shift_character("c", shift, 1)
  end

  def test_it_can_write_message
    shift = {A: 1, B: 1, C: 1, D: 2}
    expected = "ifmnpaxqsme"
    assert_equal expected, @enigma.message_writer("hello world", shift)
  end

end

require './test/test_helper'
require './lib/enigma'

class CrackableTest < Minitest::Test

  def setup
    @enigma = Enigma.new()
    @current_date = DateTime.now.strftime "%d%m%y"
  end

  def test_it_can_get_last_four_character_positions
    expected = ['s', 's', 'i', 'h']
    assert_equal expected, @enigma.last_four_characters_positions("beaweqihssi")
  end

  def test_it_can_get_expected_message_end
    expected1 = "end "
    assert_equal expected1, @enigma.expected_message_end("beaweqihssi")

    expected2 = "nd e"
    assert_equal expected2, @enigma.expected_message_end("eaweqihssi")

    expected3 = "d en"
    assert_equal expected3, @enigma.expected_message_end("aweqihssi")

    expected4 = " end"
    assert_equal expected4, @enigma.expected_message_end("weqihssi")
  end

  def test_it_can_crack_shifts
    expected = [13, 22, 22, 46]
    assert_equal expected, @enigma.crack_shifts(['s', 's', 'i', 'h'], "end ")
  end

  def test_it_can_crack_keys
    offset = {A: 2,
              B: 4,
              C: 0,
              D: 0}
    expected = ["12", "28", "86", "62"]
    assert_equal expected, @enigma.crack_keys([13, 22, 22, 46], offset)
  end

  def test_it_can_combine_keys
    expected = "12345"
    assert_equal expected, @enigma.combine_keys(["12","23","34","45"])
  end

end

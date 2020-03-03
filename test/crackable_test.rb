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
end

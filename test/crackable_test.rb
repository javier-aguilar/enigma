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

end

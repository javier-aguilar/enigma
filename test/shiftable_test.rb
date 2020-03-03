require './test/test_helper'
require './lib/enigma'

class CrackableTest < Minitest::Test

  def setup
    @enigma = Enigma.new()
    @current_date = DateTime.now.strftime "%d%m%y"
  end

  def test_it_rotate_character
    expected = "c"
    assert_equal expected, @enigma.character_rotate("a", 2)
  end

end

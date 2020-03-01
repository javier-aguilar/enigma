require './test/test_helper'
require 'date'
require './lib/enigma'

class EnigmaTest < Minitest::Test

  def setup
    @enigma = Enigma.new()
  end

  def test_it_exists
    assert_instance_of Enigma, @enigma
  end

  def test_it_can_generate_randomize_five_digits
    number = @enigma.randomize_five_digits

    assert (0..99999).include?(number.to_i)
    assert_equal 5, number.length
  end

end

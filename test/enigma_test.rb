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

  def test_it_can_generate_keys
    key = @enigma.generate_keys("02715")

    assert (0..99).include?(key[:A].to_i)
    assert (0..99).include?(key[:B].to_i)
    assert (0..99).include?(key[:C].to_i)
    assert (0..99).include?(key[:D].to_i)
  end

  def test_it_can_generate_offsets
    offset = @enigma.generate_offsets("040895")

    assert (0..9).include?(offset[:A].to_i)
    assert (0..9).include?(offset[:B].to_i)
    assert (0..9).include?(offset[:C].to_i)
    assert (0..9).include?(offset[:D].to_i)
  end

end

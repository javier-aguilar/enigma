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
    number = @enigma.randomize_five_digits
    key1 = @enigma.generate_keys(number)

    assert (0..99).include?(key1[:A].to_i)
    assert (0..99).include?(key1[:B].to_i)
    assert (0..99).include?(key1[:C].to_i)
    assert (0..99).include?(key1[:D].to_i)

    key2 = @enigma.generate_keys("02715")
    assert_equal "02", key2[:A]
    assert_equal "27", key2[:B]
    assert_equal "71", key2[:C]
    assert_equal "15", key2[:D]
  end

  def test_it_can_generate_offsets
    offset = @enigma.generate_offsets("040895")

    assert (0..9).include?(offset[:A].to_i)
    assert (0..9).include?(offset[:B].to_i)
    assert (0..9).include?(offset[:C].to_i)
    assert (0..9).include?(offset[:D].to_i)
  end

end

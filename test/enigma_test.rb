require './test/test_helper'
require 'date'
require './lib/enigma'

class EnigmaTest < Minitest::Test

  def setup
    @enigma = Enigma.new()
    @current_date = DateTime.now.strftime "%d%m%y"
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
    offset1 = @enigma.generate_offsets(@current_date)

    assert (0..9).include?(offset1[:A].to_i)
    assert (0..9).include?(offset1[:B].to_i)
    assert (0..9).include?(offset1[:C].to_i)
    assert (0..9).include?(offset1[:D].to_i)

    offset2 = @enigma.generate_offsets("040895")

    assert_equal "1", offset2[:A]
    assert_equal "0", offset2[:B]
    assert_equal "2", offset2[:C]
    assert_equal "5", offset2[:D]
  end

  def test_it_can_generate_shifts
    expected = {
      A: 2 + 1,
      B: 27 + 0,
      C: 71 + 2,
      D: 15 + 5
    }
    assert_equal expected, @enigma.generate_shifts("02715", "040895")
  end

  def test_it_can_encrypt
    expected = {
      encryption: "keder ohulw",
      key: "02715",
      date: "040895"
    }
    assert_equal expected, @enigma.encrypt("hello world", "02715", "040895")
  end

  def test_it_can_encrypt_with_uppercase_and_special_characters
    expected = {
      encryption: "keder ohulw!!a$",
      key: "02715",
      date: "040895"
    }
    assert_equal expected, @enigma.encrypt("HELLO world!!a$", "02715", "040895")
  end

  def test_it_can_encrypt_with_todays_date
    expected = {
      encryption: "lib sdmcvpu",
      key: "02715",
      date: @current_date
    }
    assert_equal expected, @enigma.encrypt("hello world", "02715")
  end

  def test_it_can_encrypt_with_random_key_and_todays_date
    @enigma.stubs(:randomize_five_digits).returns('12345')
    expected = {
      :encryption=>"vescb cfelk",
      :key=>"12345",
      :date=> @current_date
    }
    assert_equal expected, @enigma.encrypt("hello world")
  end

  def test_it_can_decrypt
    expected = {
      decryption: "hello world",
      key: "02715",
      date: "040895"
    }
    assert_equal expected, @enigma.decrypt("keder ohulw", "02715", "040895")
  end

  def test_it_can_decrypt_with_todays_date
    encrypted = @enigma.encrypt("hello world", "02715")
    expected = {
      decryption: "hello world",
      key: "02715",
      date: @current_date
    }
    assert_equal expected, @enigma.decrypt(encrypted[:encryption], "02715")
  end

  def test_it_can_decrypt_with_uppercase_and_special_characters
    expected = {
      decryption: "hello world!!a$",
      key: "02715",
      date: "040895"
    }
    assert_equal expected, @enigma.decrypt("keder ohulw!!a$", "02715", "040895")
  end

end

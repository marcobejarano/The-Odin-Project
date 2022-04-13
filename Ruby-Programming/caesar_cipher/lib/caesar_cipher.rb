# frozen_string_literal: true

class CaesarCipher
  def get_caesar_cipher(string, shift_factor, shift_direction)
    words = ""

    if (shift_direction == "right")
      shift = +shift_factor
    else (shift_direction == "left")
      shift = -shift_factor
    end

    array_string = string.split("")

    array_string.each do |char|
      char_num = char.ord
      if (char_num >= 65 && char_num <= 90)
        new_char_num = 65 + (char_num + shift - 65) % 26
      elsif (char_num >= 97 && char_num <= 122)
        new_char_num = 97 + (char_num + shift - 97) % 26
      else
        new_char_num = char_num
      end
      words += new_char_num.chr
    end

    words
  end
end

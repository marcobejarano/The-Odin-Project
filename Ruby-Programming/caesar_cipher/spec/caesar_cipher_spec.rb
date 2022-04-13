# frozen_string_literal: true

# spec/caesar_cipher_spec.rb
require './lib/caesar_cipher.rb'

describe CaesarCipher do
  subject { CaesarCipher.new }

  describe "get_caesar_cipher" do
    it "works well with small positive shift" do
      expect(subject.get_caesar_cipher('Abc', 3, 'right')).to eql('Def')
    end

    it "works well with small negative shift" do
      expect(subject.get_caesar_cipher('Tuv', 4, 'left')).to eql('Pqr')
    end

    it "works well with long positive shift" do
      expect(subject.get_caesar_cipher('Abc', 85, 'right')).to eql('Hij')
    end

    it "works well with long negative shift" do
      expect(subject.get_caesar_cipher('Hij', 85, 'left')).to eql('Abc')
    end

    it "works well with a phrase with punctuation" do
      expect(subject.get_caesar_cipher('What a string!', 5, 'right')).to eql('Bmfy f xywnsl!')
    end
  end
end

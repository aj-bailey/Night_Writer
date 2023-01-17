require_relative 'spec_helper'

RSpec.describe BrailleChar do
  let(:braille_char) { BrailleChar.new({letter: "a", top_row: "0.", middle_row: "..", bottom_row: ".."})}

  describe '#initialize' do
    it 'exists' do
      expect(braille_char).to be_a(BrailleChar)
    end

    it 'has readable letter' do
      expect(braille_char.letter).to eq("a")
    end

    it 'has readable top row' do
      expect(braille_char.top_row).to eq("0.")
    end

    it 'has readable middle row' do
      expect(braille_char.middle_row).to eq("..")
    end

    it 'has readable bottom row' do
      expect(braille_char.bottom_row).to eq("..")
    end
  end
end
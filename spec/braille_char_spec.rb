require "braille_char"

RSpec.describe BrailleChar do
  let(:braille_char) { BrailleChar.new({letter: "a", top_row: "0.", middle_row: "..", bottom_row: ".."})}

  describe '#initialize' do
    it 'exists' do
      expect(braille_char).to be_a(BrailleChar)
    end
  end
end
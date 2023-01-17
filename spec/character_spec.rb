require_relative 'spec_helper'

RSpec.describe Character do
  let(:character) { Character.new({letter: "a", top_row: "0.", middle_row: "..", bottom_row: ".."})}

  describe '#initialize' do
    it 'exists' do
      expect(character).to be_a(Character)
    end

    it 'has readable letter' do
      expect(character.letter).to eq("a")
    end

    it 'has readable top row' do
      expect(character.top_row).to eq("0.")
    end

    it 'has readable middle row' do
      expect(character.middle_row).to eq("..")
    end

    it 'has readable bottom row' do
      expect(character.bottom_row).to eq("..")
    end
  end
end
require_relative 'spec_helper'

RSpec.describe CharacterWriter do
  let(:character_writer) { CharacterWriter.new(["./spec/fixtures/test_input.txt", "./spec/fixtures/test_output.txt"])}

  describe '#initialize' do
    it 'exists' do
      expect(character_writer).to be_a(CharacterWriter)
    end
  end
end
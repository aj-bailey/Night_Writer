require_relative 'spec_helper'

RSpec.describe AlphabetWriter do
  let(:alphabet_writer) { AlphabetWriter.new(["./spec/fixtures/test_braille_input.txt", "./spec/fixtures/test_braille_output.txt"])}

  describe '#initialize' do
    it 'exists' do
      expect(alphabet_writer).to be_a(AlphabetWriter)
    end
  end
end
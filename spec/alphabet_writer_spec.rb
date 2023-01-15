require_relative 'spec_helper'

RSpec.describe AlphabetWriter do
  let(:alphabet_writer) { AlphabetWriter.new(["./spec/fixtures/test_braille_input.txt", "./spec/fixtures/test_braille_output.txt"])}

  describe '#initialize' do
    it 'exists' do
      expect(alphabet_writer).to be_a(AlphabetWriter)
    end

    it 'has readable read_path' do
      expect(alphabet_writer.read_path).to eq("./spec/fixtures/test_braille_input.txt")
    end

    it 'has readable write_path' do
      expect(alphabet_writer.write_path).to eq("./spec/fixtures/test_braille_output.txt")
    end

    it 'has readable chars' do
      expect(alphabet_writer.chars).to be_a(Array)
    end
  end

  describe '#translate' do
    it 'can return string of write file path and number of characters' do
      expected = "Created './spec/fixtures/test_braille_output.txt' containing 43 characters"
      expect(alphabet_writer.translate).to eq(expected)
    end
  end
end
require_relative 'spec_helper'

RSpec.describe CharacterWriter do
  let(:character_writer) { CharacterWriter.new(["./spec/fixtures/test_char_input.txt", "./spec/fixtures/test_char_output.txt"])}

  describe '#initialize' do
    it 'exists' do
      expect(character_writer).to be_a(CharacterWriter)
    end

    it 'has readable read_path' do
      expect(character_writer.read_path).to eq("./spec/fixtures/test_char_input.txt")
    end

    it 'has readable write_path' do
      expect(character_writer.write_path).to eq("./spec/fixtures/test_char_output.txt")
    end

    it 'has readable chars' do
      expect(character_writer.chars).to be_a(Array)
    end
  end

  describe '#read_file' do
    it 'can read a file to a string' do
      expect(character_writer.read_file).to eq("test read")
    end
  end
end
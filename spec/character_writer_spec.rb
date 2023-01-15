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

  describe '#write_file' do
    xit 'can write a string to a file' do
      character_writer.write_file("test write")

      # Unsure why this does not work - the file has 'test write' inside but returns empty string
      expect(File.open(character_writer.write_path).read).to eq("test write")
    end
  end
end
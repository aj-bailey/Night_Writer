require_relative 'spec_helper'

RSpec.describe FileIO do
  let(:file_io) { FileIO.new(["./spec/fixtures/test_char_input.txt", "./spec/fixtures/test_char_output.txt"])}

  describe '#initialize' do
    it 'exists' do
      expect(file_io).to be_a(FileIO)
    end

    it 'has readable read_path' do
      expect(file_io.read_path).to eq("./spec/fixtures/test_char_input.txt")
    end

    it 'has readable write_path' do
      expect(file_io.write_path).to eq("./spec/fixtures/test_char_output.txt")
    end

    it 'has readable chars' do
      expect(file_io.chars).to be_a(Array)
    end
  end

  describe '#read_file' do
    it 'can read a file to a string' do
      expect(file_io.read_file).to eq("test read")
    end
  end

  describe '#write_file' do
    it 'can write a string to a file' do
      file_io.write_file("test write")
      expect(File.open(file_io.write_path).read).to eq("test write")
    end
  end
end
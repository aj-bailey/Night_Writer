require_relative 'spec_helper'

RSpec.describe BrailleWriter do
  let(:braille_writer) { BrailleWriter.new(["message.txt", "braille.txt"]) }

  describe '#initialize' do
    it 'exists' do
      expect(braille_writer).to be_a(BrailleWriter)
    end

    it 'has readable read_path' do
      expect(braille_writer.read_path).to eq("message.txt")
    end

    it 'has readable write_path' do
      expect(braille_writer.write_path).to eq("braille.txt")
    end
  end
end
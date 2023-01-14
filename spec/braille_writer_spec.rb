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

    it 'has readable chars' do
      expect(braille_writer.chars).to be_a(Array)
    end
  end

  describe '#translate' do
    it 'can return string of write file path and number of characters' do
      expected = "Created 'braille.txt' containing 43 characters"
      expect(braille_writer.translate).to eq(expected)
    end
  end

  describe '#convert_text' do
    it 'can convert single alphabetical lowercase letter to braille' do
      expect(braille_writer.convert_text('a')).to eq("0. \n.. \n.. \n\n")
    end

    it 'can convert multiple alphabetical lowercase letters to braille' do
      expect(braille_writer.convert_text('abc')).to eq("0. 0. 00 \n.. 0. .. \n.. .. .. \n\n")
    end

    it 'can wrap braille text after every 40 characters' do
      text = "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa"

      expected1 = "0. 0. 0. 0. 0. 0. 0. 0. 0. 0. 0. 0. 0. 0. 0. 0. 0. 0. 0. 0. 0. 0. 0. 0. 0. 0. 0. 0. 0. 0. 0. 0. 0. 0. 0. 0. 0. 0. 0. 0. \n"
      expected2 = ".. .. .. .. .. .. .. .. .. .. .. .. .. .. .. .. .. .. .. .. .. .. .. .. .. .. .. .. .. .. .. .. .. .. .. .. .. .. .. .. \n"
      expected3 = ".. .. .. .. .. .. .. .. .. .. .. .. .. .. .. .. .. .. .. .. .. .. .. .. .. .. .. .. .. .. .. .. .. .. .. .. .. .. .. .. \n\n"
      expected4 = "0. \n.. \n.. \n\n"
      expected = expected1.concat(expected2).concat(expected3).concat(expected4)
    
      expect(braille_writer.convert_text(text)).to eq(expected)
    end
  end
end
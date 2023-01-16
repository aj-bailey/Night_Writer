require_relative 'spec_helper'

RSpec.describe BrailleWriter do
  let(:braille_writer) { BrailleWriter.new(["./spec/fixtures/test_input.txt", "./spec/fixtures/test_output.txt"]) }

  describe '#initialize' do
    it 'exists' do
      expect(braille_writer).to be_a(BrailleWriter)
    end

    it 'has readable read_path' do
      expect(braille_writer.read_path).to eq("./spec/fixtures/test_input.txt")
    end

    it 'has readable write_path' do
      expect(braille_writer.write_path).to eq("./spec/fixtures/test_output.txt")
    end

    it 'has readable chars' do
      expect(braille_writer.chars).to be_a(Array)
    end
  end

  describe '#translate' do
    it 'can return string of write file path and number of characters' do
      expected = "Created './spec/fixtures/test_output.txt' containing 43 characters"
      expect(braille_writer.translate).to eq(expected)
    end
  end

  describe '#convert_text' do
    it 'can convert single alphabetical lowercase letter to braille' do
      expect(braille_writer.convert_text('a')).to eq("0.\n..\n..")
    end

    it 'can convert multiple alphabetical lowercase letters to braille' do
      expect(braille_writer.convert_text('abc')).to eq("0. 0. 00\n.. 0. ..\n.. .. ..")
    end

    it 'can wrap braille text after every 40 characters' do
      text = "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa"

      expected1 = "0. 0. 0. 0. 0. 0. 0. 0. 0. 0. 0. 0. 0. 0. 0. 0. 0. 0. 0. 0. 0. 0. 0. 0. 0. 0. 0. 0. 0. 0. 0. 0. 0. 0. 0. 0. 0. 0. 0. 0.\n"
      expected2 = ".. .. .. .. .. .. .. .. .. .. .. .. .. .. .. .. .. .. .. .. .. .. .. .. .. .. .. .. .. .. .. .. .. .. .. .. .. .. .. ..\n"
      expected3 = ".. .. .. .. .. .. .. .. .. .. .. .. .. .. .. .. .. .. .. .. .. .. .. .. .. .. .. .. .. .. .. .. .. .. .. .. .. .. .. ..\n\n"
      expected4 = "0.\n..\n.."
      expected = expected1.concat(expected2).concat(expected3).concat(expected4)
    
      expect(braille_writer.convert_text(text)).to eq(expected)
    end
  end

  describe '#invalidate_characters' do
    it 'will remove invalid characters' do
      expect(braille_writer.invalidate_characters("aBc! ")).to eq("ac ")
    end

    it 'will replace line breaks with space character' do
      expect(braille_writer.invalidate_characters("a\nbc")).to eq("a bc")
    end
  end

  describe '#lines_of_braille' do
    it 'can change lines of text to lines of braille' do
      text = ["abc"]
      expected = [
                  [
                    ["0.", "..", ".."], 
                    ["0.", "0.", ".."], 
                    ["00", "..", ".."]
                  ]
                 ]

      expect(braille_writer.lines_of_braille(text)).to eq(expected)
    end
  end

  describe '#lines_of_braille_to_string' do
    it 'can change lines of braille into a string' do
      text = [
               [
                 ["0.", "..", ".."], 
                 ["0.", "0.", ".."], 
                 ["00", "..", ".."]
               ]
             ]

      expect(braille_writer.lines_of_braille_to_string(text)).to eq("0. 0. 00\n.. 0. ..\n.. .. ..")
    end
  end
end
require_relative 'spec_helper'

RSpec.describe NightWriter do
  let(:night_writer) { NightWriter.new(["./spec/fixtures/test_input.txt", "./spec/fixtures/test_output.txt"]) }

  describe '#initialize' do
    it 'exists' do
      expect(night_writer).to be_a(NightWriter)
    end

    it 'has readable read_path' do
      expect(night_writer.read_path).to eq("./spec/fixtures/test_input.txt")
    end

    it 'has readable write_path' do
      expect(night_writer.write_path).to eq("./spec/fixtures/test_output.txt")
    end

    it 'has readable chars' do
      expect(night_writer.chars).to be_a(Array)
    end
  end

  describe '#translate' do
    it 'can return string of write file path and number of characters' do
      expected = "Created './spec/fixtures/test_output.txt' containing 43 characters"
      expect(night_writer.translate).to eq(expected)
    end
  end

  describe '#convert_text' do
    it 'can convert single alphabetical lowercase letter to braille' do
      expect(night_writer.convert_text('a')).to eq("0.\n..\n..")
    end

    it 'can convert multiple alphabetical lowercase letters to braille' do
      expect(night_writer.convert_text('abc')).to eq("0. 0. 00\n.. 0. ..\n.. .. ..")
    end

    it 'can wrap braille text after every 40 characters' do
      text = "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa"

      expected1 = "0. 0. 0. 0. 0. 0. 0. 0. 0. 0. 0. 0. 0. 0. 0. 0. 0. 0. 0. 0. 0. 0. 0. 0. 0. 0. 0. 0. 0. 0. 0. 0. 0. 0. 0. 0. 0. 0. 0. 0.\n"
      expected2 = ".. .. .. .. .. .. .. .. .. .. .. .. .. .. .. .. .. .. .. .. .. .. .. .. .. .. .. .. .. .. .. .. .. .. .. .. .. .. .. ..\n"
      expected3 = ".. .. .. .. .. .. .. .. .. .. .. .. .. .. .. .. .. .. .. .. .. .. .. .. .. .. .. .. .. .. .. .. .. .. .. .. .. .. .. ..\n\n"
      expected4 = "0.\n..\n.."
      expected = expected1.concat(expected2).concat(expected3).concat(expected4)
    
      expect(night_writer.convert_text(text)).to eq(expected)
    end
  end

  describe '#invalidate_characters' do
    it 'can remove invalid characters' do
      expect(night_writer.invalidate_characters("abc! ")).to eq("abc ")
    end

    it 'can remove line breaks' do
      expect(night_writer.invalidate_characters("a\nbc")).to eq("abc")
    end
  end

  describe '#lines_of_braille' do
    it 'can change lines of text to lines of braille' do
      text = ["aBc"]
      expected = [
                  [
                    ["0.", "..", ".."], 
                    ["..", "..", ".0"],
                    ["0.", "0.", ".."], 
                    ["00", "..", ".."]
                  ]
                 ]

      expect(night_writer.lines_of_braille(text)).to eq(expected)
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

      expect(night_writer.lines_of_braille_to_string(text)).to eq("0. 0. 00\n.. 0. ..\n.. .. ..")
    end
  end

  describe '#char_to_braille' do
    it 'can change alphabetical character to braille character' do
      expect(night_writer.char_to_braille("a")).to eq(["0.", "..", ".."])
    end
  end

  describe '#insert_uppercase_braille_placeholders' do
    it 'can insert braille uppercase into each index' do
      lines_of_braille = [
        ["0.", "..", ".."], ["..", "..", ".."], 
        ["0.", "..", ".."], ["..", "..", ".."], 
        ["0.", "..", ".."], ["..", "..", ".."], 
        ["0.", "..", ".."]
      ]

      indices = [0, 2, 4, 6]
      
      expected = [
        ["..", "..", ".0"], ["0.", "..", ".."], ["..", "..", ".."],
        ["..", "..", ".0"], ["0.", "..", ".."], ["..", "..", ".."],
        ["..", "..", ".0"], ["0.", "..", ".."], ["..", "..", ".."],
        ["..", "..", ".0"], ["0.", "..", ".."]
      ]
      
      expect(night_writer.insert_uppercase_braille_placeholders(indices, lines_of_braille)).to eq(expected)
    end
  end

  describe '#adjust_line_lengths' do
    it 'can pop characters in excess of 40 into the next array' do
      lines = [
        [
          "a","a","a","a","a","a","a","a","a","a",
          "a","a","a","a","a","a","a","a","a","a",
          "a","a","a","a","a","a","a","a","a","a",
          "a","a","a","a","a","a","a","a","a","a",
          "a"
        ]
      ]

      expected = [
        [
          "a","a","a","a","a","a","a","a","a","a",
          "a","a","a","a","a","a","a","a","a","a",
          "a","a","a","a","a","a","a","a","a","a",
          "a","a","a","a","a","a","a","a","a","a"
        ],
        [
          "a"
        ]
      ]

      expect(night_writer.adjust_line_lengths(lines)).to eq(expected)
    end
  end
end
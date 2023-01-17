require_relative 'spec_helper'

RSpec.describe NightReader do
  let(:night_reader) { NightReader.new(["./spec/fixtures/test_braille_input.txt", "./spec/fixtures/test_braille_output.txt"])}

  describe '#initialize' do
    it 'exists' do
      expect(night_reader).to be_a(NightReader)
    end

    it 'has readable read_path' do
      expect(night_reader.read_path).to eq("./spec/fixtures/test_braille_input.txt")
    end

    it 'has readable write_path' do
      expect(night_reader.write_path).to eq("./spec/fixtures/test_braille_output.txt")
    end

    it 'has readable chars' do
      expect(night_reader.chars).to be_a(Array)
    end
  end

  describe '#translate' do
    it 'can return string of write file path and number of characters' do
      expected = "Created './spec/fixtures/test_braille_output.txt' containing 43 characters"
      expect(night_reader.translate).to eq(expected)
    end
  end

  describe '#convert_text' do
    it 'can convert single braille lowercase letter to alphabetical' do
      expect(night_reader.convert_text("0. \n.. \n.. \n\n")).to eq('a')
    end

    it 'can convert multiple braille lowercase letters to alphabetical' do
      expect(night_reader.convert_text("0. 0. 00 \n.. 0. .. \n.. .. .. \n\n")).to eq('abc')
    end

    it 'can wrap alphabetical text after every 40 characters' do
      text1 = "0. 0. 0. 0. 0. 0. 0. 0. 0. 0. 0. 0. 0. 0. 0. 0. 0. 0. 0. 0. 0. 0. 0. 0. 0. 0. 0. 0. 0. 0. 0. 0. 0. 0. 0. 0. 0. 0. 0. 0. \n"
      text2 = ".. .. .. .. .. .. .. .. .. .. .. .. .. .. .. .. .. .. .. .. .. .. .. .. .. .. .. .. .. .. .. .. .. .. .. .. .. .. .. .. \n"
      text3 = ".. .. .. .. .. .. .. .. .. .. .. .. .. .. .. .. .. .. .. .. .. .. .. .. .. .. .. .. .. .. .. .. .. .. .. .. .. .. .. .. \n\n"
      text4 = "0. \n.. \n.. "
      text = text1.concat(text2).concat(text3).concat(text4)

      
      expected = "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa\na"

      expect(night_reader.convert_text(text)).to eq(expected)
    end
  end

  describe '#invalidate_characters' do
    it 'can remove spaces' do
      expect(night_reader.invalidate_characters("0. ")).to eq("0.")
    end

    it 'can replace double line breaks with single line breaks' do
      expect(night_reader.invalidate_characters("0.\n..\n..\n\n")).to eq("0.\n..\n..\n")
    end
  end

  describe '#braille_char_to_alphabetical' do
    it 'can change braille character into alphabetical' do
      braille_char = [".0", "00", "0."]
      expect(night_reader.braille_char_to_alphabetical(braille_char)).to eq("t")
    end
  end

  describe '#lines_of_braille' do
    it 'can create lines of braille from string' do
      expected = [
        ["00", "0.", "00"],
        [".0", ".0", "00"],
        ["..", "0.", ".."]
      ]

      expect(night_reader.lines_of_braille("000.00\n.0.000\n..0...")).to eq(expected)
    end
  end

  describe '#sets_of_three_braille_lines' do
    it 'can group sets of three lines of braille' do
      lines_of_braille = [
        [".0", "0.", "0.", "..", "00", "0.", ".0", "00", "0.", "..", "0.", "0.", "0.",
        ".0", "00", "..", "00", "0.", "00", "..", ".0", "0.", "00", "00", ".0", "..", 
        "0.", "0.", "0.", "0.", "..", ".0", "0.", "0.", "..", "0.", "0.", "0.", "00", ".."],

        ["00", "00", ".0", "..", "00", "..", "0.", "..", "..", "..", "0.", "00", ".0", 
          "00", ".0", "..", "0.", ".0", "..", "..", "00", "..", "..", "0.", "0.", "..",
          ".0", "0.", ".0", "00", "..", "00", "00", ".0", "..", "0.", "..", ".0", ".0", ".."],

        ["0.", "..", "..", "..", "0.", "00", "..", "..", "0.", "..", "..", "0.", "0.",
          ".0", "0.", "..", "..", "0.", "00", "..", "..", "00", "0.", "0.", "0.", "..",
          "0.", "00", "..", "0.", "..", "0.", "..", "..", "..", "0.", "..", "00", "00", ".."],

        ["00", "0.", "00"],
        [".0", ".0", "00"],
        ["..", "0.", ".."]
      ]

      expected = [
        [
          [".0", "0.", "0.", "..", "00", "0.", ".0", "00", "0.", "..", "0.", "0.", "0.",
           ".0", "00", "..", "00", "0.", "00", "..", ".0", "0.", "00", "00", ".0", "..",
           "0.", "0.", "0.", "0.", "..", ".0", "0.", "0.", "..", "0.", "0.", "0.", "00", ".."],

          ["00", "00", ".0", "..", "00", "..", "0.", "..", "..", "..", "0.", "00", ".0",
           "00", ".0", "..", "0.", ".0", "..", "..", "00", "..", "..", "0.", "0.", "..",
            ".0", "0.", ".0", "00", "..", "00", "00", ".0", "..", "0.", "..", ".0", ".0", ".."],

          ["0.", "..", "..", "..", "0.", "00", "..", "..", "0.", "..", "..", "0.", "0.",
           ".0", "0.", "..", "..", "0.", "00", "..", "..", "00", "0.", "0.", "0.", "..",
            "0.", "00", "..", "0.", "..", "0.", "..", "..", "..", "0.", "..", "00", "00", ".."]
        ],

        [ ["00", "0.", "00"], [".0", ".0", "00"], ["..", "0.", ".."] ]
      ]

      expect(night_reader.sets_of_three_braille_lines(lines_of_braille)).to eq(expected)
    end
  end

  describe '#convert_to_alphabetical' do
    it 'can convert braille lines to alphabetical' do
      sets_of_three_braille_lines = [
        [
          [".0", "0.", "0.", "..", "00", "0.", ".0", "00", "0.", "..", "0.", "0.", "0.",
          ".0", "00", "..", "00", "0.", "00", "..", ".0", "0.", "00", "00", ".0", "..",
          "0.", "0.", "0.", "0.", "..", ".0", "0.", "0.", "..", "0.", "0.", "0.", "00", ".."],

          ["00", "00", ".0", "..", "00", "..", "0.", "..", "..", "..", "0.", "00", ".0",
          "00", ".0", "..", "0.", ".0", "..", "..", "00", "..", "..", "0.", "0.", "..",
            ".0", "0.", ".0", "00", "..", "00", "00", ".0", "..", "0.", "..", ".0", ".0", ".."],

          ["0.", "..", "..", "..", "0.", "00", "..", "..", "0.", "..", "..", "0.", "0.",
          ".0", "0.", "..", "..", "0.", "00", "..", "..", "00", "0.", "0.", "0.", "..",
            "0.", "00", "..", "0.", "..", "0.", "..", "..", "..", "0.", "..", "00", "00", ".."]
        ],

        [ ["00", "0.", "00"], [".0", ".0", "00"], ["..", "0.", ".."] ]
      ]

      expected = "the quick brown fox jumps over the lazy \ndog"
      
      expect(night_reader.convert_to_alphabetical(sets_of_three_braille_lines)).to eq(expected)
    end

    it 'can convert braille uppercase letters to uppercase alphabetical' do
      sets_of_three_braille_lines = [[["..", "0."], ["..", ".."], [".0", ".."]]]

      expect(night_reader.convert_to_alphabetical(sets_of_three_braille_lines)).to eq("A")
    end
  end
end
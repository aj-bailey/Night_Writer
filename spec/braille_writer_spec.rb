require_relative 'spec_helper'

RSpec.describe BrailleWriter do
  let(:braille_writer) { BrailleWriter.new(["message.txt", "braille.txt"]) }

  describe '#initialize' do
    it 'exists' do
      expect(braille_writer).to be_a(BrailleWriter)
    end
  end
end
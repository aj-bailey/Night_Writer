require_relative 'braille_writer'

braille_writer = BrailleWriter.new(ARGV)

p braille_writer.translate
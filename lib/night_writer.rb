require_relative 'braille_writer'

braille_writer = BrailleWriter.new(ARGV)

puts braille_writer.translate
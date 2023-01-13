class BrailleWriter < File
  attr_reader :read_path, 
              :write_path

  def initialize(argv)
    @read_path = argv[0]
    @write_path = argv[1]
  end
end
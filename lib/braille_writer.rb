class BrailleWriter < File
  attr_reader :read_path, 
              :write_path

  def initialize(argv)
    @read_path = argv[0]
    @write_path = argv[1]

    p create_file
  end

  def create_file
    "Created '#{@write_path}' containing #{open(@read_path).read.length} characters"
  end
end
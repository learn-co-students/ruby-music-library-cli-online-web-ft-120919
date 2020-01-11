class MusicImporter
  attr_accessor :path

  def initialize(path)
    @path = path
  end

  def files
    files = []
    Dir.each_child(path){|filename| files << filename}
    files
  end

  def import
    files.each{ |filename| Song.create_from_filename(filename) }
  end
end
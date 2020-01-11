class MusicImporter
  
  attr_accessor :path
  
  def initialize(path)
    @path = path
  end
  
  def files
    Dir.children(self.path)
  end
  
  def import
    self.files.each do |file_name|
      Song.create_from_filename(file_name)
    end
  end
  
end
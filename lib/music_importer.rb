require 'pry'

class MusicImporter
  attr_accessor :path

  def initialize(file_path)
    @path = file_path
  end #init

  def files
    all_files = Dir.entries(@path).select{|f| f.include?(".mp3")}
  end #files

  def import 
    files.each do |f|
      Song.create_from_filename(f)
    end #each
  end #import 
end #class
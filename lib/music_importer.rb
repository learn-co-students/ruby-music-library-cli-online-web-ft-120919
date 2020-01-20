class MusicImporter 
    attr_accessor :path, :song, :artist, :genre

    def initialize(path)
        @path = path
    end

    def files #returns all imported filenames
        Dir.glob("#{path}/*").collect{ |file| file.gsub("#{path}/", "") }
    end

    def import 
        files.each do |file|
            Song.create_from_filename(file)
        end
    end
end
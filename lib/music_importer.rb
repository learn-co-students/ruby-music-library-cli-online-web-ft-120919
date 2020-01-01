require "pry"
class MusicImporter

    attr_reader :path

    def initialize(path) # accepts a file path to parse MP3 files from
        @path = path  # #path-- retrieves the path provided to the MusicImporter object
    end

    ##files-- loads all the MP3 files in the path directory, normalizes the filename to just the MP3 filename with no path
    def files
        Dir.entries(path).select{|entry| entry.include?(".mp3")}
    end

    #imports the files into the library by invoking Song.create_from_filename
    def import
        files.each do |filename|
            Song.create_from_filename(filename)
        end
    end
end
require_relative '../lib/concerns/findable.rb'

class Song
    extend Concerns::Findable
    attr_accessor :name
    attr_reader :artist, :genre
    @@all = []

    def initialize(name, artist=nil, genre=nil)
        @name = name
        self.artist=(artist) if artist != nil
        self.genre=(genre) if genre != nil
    end

    def self.all
        @@all
    end

    def self.destroy_all
        @@all.clear
    end

    def save
        @@all << self
    end

    def self.create(song)
        song = self.new(song)
        song.save
        song
    end

    def artist
        @artist
    end
    
    def artist=(artist)
        @artist = artist
        artist.add_song(self)
    end

    def genre
        @genre
    end
    
    def genre=(genre)
        @genre = genre
        genre.add_song(self)
    end

    def self.find_by_name(name) #should these be here?
        self.all.find do |x|
            x.name == name 
        end
    end

    def self.find_or_create_by_name(name)
        find_by_name(name) || self.create(name) #if that's not true, this is -- with a method!
    end    

    def self.new_from_filename(filename)
        artist, song, genre_mp3 = filename.split(" - ")
        bare_genre = genre_mp3.gsub(".mp3", "")
        artist = Artist.find_or_create_by_name(artist)
        genre = Genre.find_or_create_by_name(bare_genre)
        new(song, artist, genre)

    end

    def self.create_from_filename(filename)
        new_from_filename(filename).save
    end

end

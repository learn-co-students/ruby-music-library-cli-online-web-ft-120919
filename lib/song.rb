require 'pry'

class Song

    attr_accessor :name

    @@all = []

    def initialize(name, artist=nil, genre=nil)
        @name = name 
        @artist = artist if artist != nil && artist.class == Artist
        @genre = genre if genre != nil && genre.class == Genre
        
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

    def self.create(name)
        song = self.new(name)
        song.save
        song 
    end
    
    def artist
        @artist
        # @songs.collect{|s| s.artist}.uniq
    end

    def artist=(artist) # question on this do i need an if statement? and do this nd adds the song to the artist's collection of songs
        
        # @artist = artist
        # self.artist = Artist.create(artist)
        # artist.add_song(self)


        # @artist = artist # puts song into songs using add_song
        # self.artist = Artist.create(artist)
        
        # artist.add_song(self) unless artist.songs.include?(self)
        # if artist.songs.include?(self)
        # else
        #     artist.add_song(self) 
        # end
        # binding.pry    
    end
    
    def genre 
        @genre
    end

    # def genre=(genre)
    #     @genre = genre
    # end

    def self.find_by_name(name)
        @@all.detect { |song| song.name == name }
    end

    def self.find_or_create_by_name(name)
       self.find_by_name(name) || self.create(name) 
    end

end
require 'pry'

class Song

    attr_accessor :name

    @@all = []

    def initialize(name, artist=nil, genre=nil)
        @name = name 
        @artist = artist
        @genre = genre
        save
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
    end
    
    def artist
        @artist
        # @songs.collect{|s| s.artist}.uniq
    end

    def artist=(artist) # question on this do i need an if statement? and do this nd adds the song to the artist's collection of songs
        # if @artist != nil   
        # end
        

        # 

        @artist = artist # puts song into songs using add_song
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
end
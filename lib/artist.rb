require 'pry'

class Artist

    extend Concerns::Findable 

    attr_accessor :name

    @@all = []

    def initialize(name)
        @name = name 
        @songs = []
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

    # def self.create(name)
    #     song = self.new(name)
    # end

    def songs 
        @songs
    end

    def add_song(song)
        if song.artist == nil
           song.artist = self
        end
        # # binding.pry
        if !@songs.include?(song)
            @songs << song
        end
        # song.artist = self
        @songs
    end

    def genres 
        # binding.pry
        gen = []
        self.songs.each { |song| gen << song.genre}
        gen.uniq
        # Genre.all.select do |g|  
        #     g.songs.artist == self 
        # end
    end  

end
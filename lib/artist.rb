require_relative '../lib/concerns/findable.rb'

class Artist
    extend Concerns::Findable
    attr_accessor :name
    attr_reader :songs
    @@all = []

    def initialize(name)
        @name = name 
        @songs =[]
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

    def self.create(artist)
        artist = self.new(artist)
        artist.save
        artist
    end

    def songs
        @songs
    end

    def add_song(song)
        if song.artist == nil
            song.artist = self
        else 
            nil
        end
        if @songs.include?(song)
            nil
        else
            @songs << song
        end
        song
    end

    def genres 
        @genres = []
        @songs.each do |song|
            if @genres.include?(song.genre)
                nil
            else
                @genres << song.genre
            end
        end
        @genres
    end


end
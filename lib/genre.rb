require_relative '../lib/concerns/findable.rb'

class Genre
    extend Concerns::Findable
    attr_accessor :name
    attr_reader :songs
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

    def self.create(genre)
        genre = Genre.new(genre)
        genre.save
        genre
    end

    def songs
        @songs
    end

    def add_song(song)
        if song.genre == nil
            song.genre = self
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

    def artists
        @artists = []
        @songs.each do |song|
            if @artists.include?(song.artist)
                nil
            else
                @artists << song.artist
            end
        end
        @artists
    end


end
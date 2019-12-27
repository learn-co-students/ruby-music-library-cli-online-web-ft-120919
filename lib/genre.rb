require 'pry'

class Genre

    extend Concerns::Findable

    attr_accessor :name

    @@all = []

    def initialize(name)
        @name = name 
        save
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

    def self.create(name)
        song = self.new(name)
    end

    def songs 
        @songs
    end

    def add_song(song)
        if song.genre == nil
           song.genre = self
        end
        if !@songs.include?(song)
            @songs << song
        end
        @songs
    end
    
end
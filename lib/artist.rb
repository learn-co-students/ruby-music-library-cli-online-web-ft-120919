require_relative './concerns/findable.rb'
require 'pry'

class Artist
    attr_accessor :name
    attr_reader :songs, :genre_array
    extend Concerns::Findable

    @@all = []

    def initialize(name)
        @name = name
        @songs = []
        @genre_array = []
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
        new_artist = Artist.new(name)
        new_artist.save
        new_artist
    end

    def add_song(song_object)
        self.songs << song_object unless self.songs.include?(song_object)
        song_object.artist = self unless song_object.artist
    end

    def genres
        self.songs.each do |song_object|
            @genre_array << song_object.genre unless @genre_array.include?(song_object.genre)
        end
        @genre_array
    end
end

test_artist = Artist.new("man")

binding.pry
"goodbye"
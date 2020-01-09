require_relative './concerns/findable.rb'

class Genre
    attr_accessor :name
    attr_reader :songs, :artist_array
    extend Concerns::Findable

    @@all = []

    def initialize(name)
        @name = name
        @songs = []
        @artist_array = []
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
        new_genre = Genre.new(name)
        new_genre.save
        new_genre
    end

    def artists
        self.songs.each do |song_object|
            @artist_array << song_object.artist unless @artist_array.include?(song_object.artist)
        end
        @artist_array
    end
end
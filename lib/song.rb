require 'pry'
require_relative './artist.rb'
require_relative './genre.rb'
class Song
    attr_accessor :name 
    attr_reader :artist, :genre

    @@all = []

    def initialize(name, artist = nil, genre = nil)
        @name = name
        if artist
            self.artist = artist
        end
        if genre 
            self.genre = genre
        end 
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
        new_song = Song.new(name)
        new_song.save
        new_song
    end

    def artist=(artist_object)
        artist_object.add_song(self) unless artist_object.songs.include?(self)
        @artist = artist_object unless @artist
    end

    def genre=(genre_object)
        genre_object.songs << self unless genre_object.songs.include?(self)
        @genre = genre_object unless @genre
    end

    def self.find_by_name(name)
        @@all.detect do |song_object|
            song_object.name == name
        end
    end

    def self.find_or_create_by_name(name)
        # if self.find_by_name(name)
        #     self.find_by_name(name)
        # else
        #     self.create(name)
        # end
        self.find_by_name(name) || self.create(name)
    end

    def self.new_from_filename(filename)
        name_array = filename.split(" - ")
        artist = name_array[0]
        name = name_array[1]
        genre = name_array[2].chomp(".mp3")
        artist_object = Artist.find_or_create_by_name(artist)
        genre_object = Genre.find_or_create_by_name(genre)
        Song.new(name, artist_object, genre_object)
    end

    def self.create_from_filename(filename)
        new_song = Song.new_from_filename(filename)
        new_song.save
    end
end

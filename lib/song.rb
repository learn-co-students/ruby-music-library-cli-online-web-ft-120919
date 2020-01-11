require_relative './concerns/findable'
require 'pry'
class Song
  attr_accessor :name
  attr_reader :artist, :genre
  extend Concerns::Findable
  @@all = []

  def initialize(name, artist = nil, genre = nil)
    @name = name
    self.artist = artist unless artist.nil?
    self.genre = genre unless genre.nil?
  end

  def save
    @@all << self
    self
  end

  def self.all
    @@all
  end

  def self.destroy_all
    all.clear
  end

  def self.create(name, artist = nil, genre = nil)
    song = new(name, artist, genre)
    song.save
  end

  def self.new_from_filename(filename)
    artistname, songname, genrename = filename.chomp('.mp3').split(' - ')
    song = new(songname)
    song.artist = Artist.find_or_create_by_name(artistname)
    song.genre = Genre.find_or_create_by_name(genrename)
    song
  end

  def self.create_from_filename(filename)
    new_from_filename(filename).save
  end

  def artist=(artist)
    @artist = artist
    artist.add_song(self)
  end

  def genre=(genre)
    @genre = genre
    genre.add_song(self)
  end
end
require_relative './concerns/findable'
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
    song
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
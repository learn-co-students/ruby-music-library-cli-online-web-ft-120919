require_relative './concerns/findable'
class Artist
  attr_accessor :name
  attr_reader :songs
  extend Concerns::Findable
  @@all = []

  def initialize(name)
    @name = name
    @songs = []
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

  def self.create(name)
    artist = new(name)
    artist.save
    artist
  end

  def add_song(song)
    song.artist = self if song.artist == nil
    @songs << song unless @songs.include?(song)
  end

  def genres
    songs.map{|song| song.genre}.uniq
  end
end
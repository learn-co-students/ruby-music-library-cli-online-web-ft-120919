#require 'pry'

class Artist
  extend Concerns::Findable

  attr_accessor :name,:songs

  @@all = []

  def initialize(name)
    @name=name
    @songs=[]
  end

  def self.create(name)
    artist= Artist.new(name)
    artist.save
    artist
  end

  def save
    @@all << self
  end

  def self.all
    return @@all
  end

  def genres
    gs = @songs.collect { |song| song.genre }
    gs.uniq
  end

  def add_song(song)
    song.artist = self unless song.artist == self
    @songs << song  unless @songs.include?(song)
  end

  def self.destroy_all
    @@all.clear
  end

end

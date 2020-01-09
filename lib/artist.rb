require_relative "./concerns/findable.rb"

class Artist
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

  def save
    @@all << self
  end

  def add_song(song)
    @songs << song
    @songs.uniq!
    if song.artist == nil
      song.artist = self
    else
      return
    end
  end

  def self.create(name)
    inst = Artist.new(name)
    inst.save
    inst
  end

  def genres
    @songs.collect {|song| song.genre}.uniq
  end

  def self.destroy_all
    @@all.clear
  end
end

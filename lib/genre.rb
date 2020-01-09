require_relative "./concerns/findable.rb"

class Genre
  extend Concerns::Findable
  attr_accessor :name, :songs
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

  def self.create(name)
    inst = Genre.new(name)
    inst.save
    inst
  end

  def artists
    @songs.collect {|song| song.artist}.uniq
  end

  def self.destroy_all
    @@all.clear
  end
end

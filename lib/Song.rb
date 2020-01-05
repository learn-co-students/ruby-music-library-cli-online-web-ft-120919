

class Song 
  
  attr_accessor :name, :artist, :genre 
  
  
  @@all = []
  
  def initialize(name, artist="song")
    @name = name
    @artist = artist
    save
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
    song.name = name 
    song
  end
  
  def artist=(artist)
    @artist = artist
    artist.add_song(self)
  end
end
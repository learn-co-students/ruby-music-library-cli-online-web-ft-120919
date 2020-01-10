class Song
  attr_accessor :name
  attr_reader :artist, :genre
  
  @@all = []
  
  def initialize(name, artist = nil, genre = nil)
    @name = name
    self.artist = artist if artist
    self.genre = genre if genre
  end
  
  def artist=(artist)
    @artist = artist
    artist.add_song(self)
  end
  
  def genre=(genre)
    @genre = genre
    genre.add_song(self)
  end
  
  def save
    @@all << self
  end
  
  #class methods
  
  def self.create(name)
    obj = self.new(name)
    obj.save
    obj
  end
  
  def self.all
    @@all
  end
  
  def self.find_by_name(name)
    self.all.find {|song| song.name == name}
  end
  
  def self.find_or_create_by_name(name)
    song = self.find_by_name(name)
    song ? song : self.create(name)
  end
  
  def self.destroy_all
    @@all = []
  end
end
class Artist 
  @@all = []
attr_accessor :name, :songs, :genre  
  def initialize (name)
    @name = name
    @songs = []
    @genre = genre 
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
  def songs
    @songs
  end 
  def self.create(name)
    @@all << self.new(name)
    self
  end 
  def genres
   a = Song.all.select{|song|song.artist == self}
   a.map {|x|x.genre}.uniq
  end 
  def add_song(song)
    if song.artist == nil
      song.artist = self
      @songs << song
    end 
  end 
end 


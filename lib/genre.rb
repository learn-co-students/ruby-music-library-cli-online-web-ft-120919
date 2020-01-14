
class Genre 
  @@all = []
attr_accessor :name
  def initialize (name)
    @name = name
    @songs = []
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
    @@all << self.new(name)
    self
  end 
  def song_boy
    Song.all.select {|song| song.genre == self}
  end 
  def artists
   a = Song.all.select{|song|song.genre == self}
   a.map {|x|x.artist}.uniq
  end 
  def songs
    @songs
    #Song.all.select {|song| song.genre == self}
  end
end
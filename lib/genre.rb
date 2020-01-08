class Genre 
  extend Concerns::Findable
  
  attr_accessor :name, :artist, :songs   
  @@all = []
  
  def initialize 
    @name = name
    @artist = artist 
    @@all << self 
  end 
  
  def self.all
    @@all 
  end 
  
  def save 
    @@all << self 
  end 
  
  def destroy_all
    @@all.clear 
  end 
  
  def self.create 
    self.new(name).tap do |genre|
      genre.save 
  end 
  
  def songs 
    @songs 
  end 
  
  def artists
    artists = @songs.collect do |song|
      song.artist
    end
    artists.uniq
  end
  
end 
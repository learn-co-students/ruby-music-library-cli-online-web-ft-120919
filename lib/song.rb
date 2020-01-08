class Song 
  all = [] 
  attr_accessor :name, :artist, :genre 
  
  def initialize 
      @name = name
      @artist = artist 
      @genre = genre 
      
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
    self.new(name).tap do |song|
      song.save 
  end 
  
  def self.find_or_create_by_name(name)
    self.find_by_name(name) || self.create(name)
  end
  
  def self.new_from_filename(name)
    song_name = name.split(" - ")[1]
    artist_name = name.split(" - ")[0]
    genre_name = name.split(" - ")[2].chomp(".mp3")
    song = self.find_or_create_by_name(song_name)
    song.artist = Artist.find_or_create_by_name(artist_name)
    song.genre = Genre.find_or_create_by_name(genre_name)
    song
  end
end 


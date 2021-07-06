class Artist 
  
  extend Concerns::Findable
  
  @@all = []
  
  attr_accessor :name, :songs, :genre 
  
  def initialize
     @name = name
     @@all << self
   end 
   
   def self.all
     @@all 
   end 
   
   def save 
     @all << self 
   end 
   
   def destroy_all 
     @@all.clear 
   end 
   
   def self.create 
    self.new(name).tap do |artist|
      artist.save 
  end 
  
  def add_song(song)
    @@all << song 
    
  end 
  
  def genres
    @@all << self	  self.songs.map {|song| song.genre}.uniq
  end	    

  
end 
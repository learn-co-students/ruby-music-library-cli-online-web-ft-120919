class Song 
  @@all = []
  attr_reader :genre, :artist
  attr_accessor :name
  
  def initialize (name,artist = nil,genre = nil)
    @name = name
    if artist != nil 
      self.artist = artist
    end 
    if genre != nil 
      self.genre = genre
    end 
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
   @@all << self.new(name)
    self
  end 
  def self.find_by_name(name)
    binding.pry
   all.detect {|song| song.name == name}
  end 
end 
  def self.find_or_create_by_name(name) #look into Song class to see if artist exist, and if not, creates one
   found_song = @@all.detect {|song| song.name == name} #or .find
    if found_song
      found_song
    else 
      self.new(name) #create a new instance with the given name 
    end
  end 
   def artist=(artist)
   @artist = artist
   artist.add_song(self)
   end 
   def genre=(genre)
     @genre = genre 
    if !genre.songs.include? (self)
     genre.songs << self
    end 
   end 
end 
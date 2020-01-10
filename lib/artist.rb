class Artist
  attr_accessor :name 
  attr_reader :songs
  @@all = []
  
  def initialize(name)
    @name = name
    @songs = []
  end
  
  def save
    @@all << self
  end
  
  def add_song(song)
    if !self.songs.include?(song)
      @songs << song
      song.artist = self unless song.artist
    end
  end
  
  def genres
    @songs.collect {|song| song.genre}.uniq
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
  
  def self.destroy_all
    @@all = []
  end
end
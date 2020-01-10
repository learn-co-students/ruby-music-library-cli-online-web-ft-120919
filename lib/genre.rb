class Genre
  attr_accessor :name
  attr_reader :songs
  
  def initialize(name)
    @name = name
    @songs = []
  end
  
  def save
    @@all << self
  end
  
  def add_song(song)
    @songs << song unless @songs.include?(song)
  end
  
  def artists
    @songs.collect {|song| song.artist}.uniq
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
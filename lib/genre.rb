class Genre
  
  extend Concerns::Findable
  
  attr_accessor :name, :songs
  
  @@all = []
  
  def initialize(name)
    @name = name
    @songs = []
  end
  
  def save
    @@all << self
  end
  
  def self.all
    @@all
  end
  
  def self.create(name)
    self.new(name).tap {|song| song.save}
  end

  def self.destroy_all
    @@all.clear
  end
  
  def artists
    self.songs.collect {|song| song.artist}.uniq
  end
  
  def add_song(song)
    song.genre = self if song.genre == nil
    @songs << song if !@songs.include?(song)
  end
  
  def self.genre_list
    self.all.collect {|genre| genre.name}
  end

end
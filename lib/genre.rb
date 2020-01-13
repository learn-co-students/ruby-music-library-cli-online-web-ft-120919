class Genre
  extend Concerns::Findable
  @@all = []
  attr_accessor  :name, :songs

  def initialize(name)
    @name=name
    @songs=[]
  end

  def self.create(name)
    genre = Genre.new(name)
    genre.save
    genre
  end

  def save
    @@all << self
  end

  def self.all
    return @@all
  end

  def add_song(song)
    song.genre = self unless song.genre == self
    @songs << song  unless @songs.include?(song)
  end

  def songs
    @songs
  end

  def artists
    song_collection = self.songs
    artists = song_collection.collect {|s| s.artist}
    artists.uniq
  end

  def self.destroy_all
    @@all.clear
  end
end
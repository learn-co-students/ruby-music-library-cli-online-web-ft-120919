class Song
  
  extend Concerns::Findable
  
  attr_accessor :name, :genre
  attr_reader :artist
  
  @@all = []
  
  def initialize(name, artist = nil, genre = nil)
    @name = name
    self.artist = artist if artist != nil
    self.genre = genre if genre != nil
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
  
  def artist=(artist)
    @artist = artist
    artist.add_song(self)
  end
  
  def genre=(genre)
    @genre = genre
    genre.add_song(self)
  end
  
  def self.create_from_filename(file_name)
    self.new_from_filename(file_name).save
  end
  
  def self.new_from_filename(file_name)
    data = file_name.split(" - ")
    song = self.new(data[1])
    song.artist = Artist.find_or_create_by_name(data[0])
    song.genre = Genre.find_or_create_by_name(data[2].chomp(".mp3"))
    song
  end
  
end
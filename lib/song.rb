class Song
  attr_accessor :name, :artist, :genre
  @@all = []
  def initialize(name, artist = nil, genre = nil)
    @name = name
    self.artist = artist if artist != nil
    self.genre = genre if genre != nil
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
    instance = Song.new(name)
    instance.save
    instance
  end

  def artist=(artist)
    @artist = artist
    self.artist.add_song(self)
  end

  def genre=(genre)
    @genre = genre
    self.genre.add_song(self)
  end

  def self.find_by_name(name)
    @@all.detect { |song| song.name == name }
  end

  def self.find_or_create_by_name(name)
    if find_by_name(name).nil?
      create(name)
    else
      find_by_name(name)
    end
  end

  def self.new_from_filename(filename)
    file_bits = filename.gsub(/(\.mp3)/,'')
    file_bits = file_bits.split(" - ")
    artist = Artist.find_or_create_by_name(file_bits[0])
    song = Song.find_or_create_by_name(file_bits[1])
    genre = Genre.find_or_create_by_name(file_bits[2])
    song.genre = genre
    song.artist = artist
    song
  end

  def self.create_from_filename(filename)
    new_song = Song.new_from_filename(filename)
    new_song.save
    new_song
  end
end
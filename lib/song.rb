class Song
  attr_accessor :name, :genre
  attr_reader :artist
  @@all = []

  def initialize(name, artist = nil, genre = nil)
    @name = name
    self.artist=(artist)
    self.genre=(genre)
  end

  def self.all
    @@all
  end

  def save
    @@all << self
  end

  def self.create(name)
    inst = Song.new(name)
    inst.save
    inst
  end

  def self.new_from_filename(file)
    clean = file.chomp(".mp3").split(" - ")
    song_name = clean[1]
    artist = Artist.find_or_create_by_name(clean[0])
    genre = Genre.find_or_create_by_name(clean[2])
    inst = self.find_or_create_by_name(song_name)
    inst.artist=(artist)
    inst.genre=(genre)
    inst
  end

  def self.create_from_filename(file)
    inst = self.new_from_filename(file)
    @@all << inst
  end

  def artist=(artist)
    @artist = artist
    artist.add_song(self) if artist != nil
  end

  def genre=(genre)
    if genre != nil
      @genre = genre
      genre.songs << self
      genre.songs.uniq!
    else
      return
    end
  end

  def self.find_by_name(name)
    @@all.select {|song| song.name == name}.first
  end

  def self.find_or_create_by_name(name)
    if self.find_by_name(name) != nil
      self.find_by_name(name)
    else
      self.create(name)
    end
  end

  def self.destroy_all
    @@all.clear
  end
end

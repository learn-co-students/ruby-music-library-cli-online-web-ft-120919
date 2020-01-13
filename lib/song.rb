#require 'pry'
class Song
  extend Concerns::Findable
  attr_accessor :name, :genre
  attr_reader :artist
  @@all = []

  def initialize(name, artist=nil, genre=nil)
    @name=name
    if(artist!=nil)
      self.artist = artist
    end
    if (genre!=nil)
      self.genre= genre
    end
  end

  def self.create(name, artist=nil, genre=nil)
    song = Song.new(name, artist, genre)
    song.save
    song
      #binding.pry
  end

  def save
    @@all << self
  end

  def artist=(artist)
    @artist = artist
    @artist.add_song(self)
  end

  def genre=(genre)
    @genre = genre
    @genre.add_song(self)
  end

  def self.all
    return @@all
  end

  def self.destroy_all
    self.all.clear
  end

  def song_from_filename(artist_song_genre)
    return song_name
  end

  def self.songInfo_from_file(filename)
    artist_song_genre_array = filename.split(" - ")
    artist_s =artist_song_genre_array[0]
    artist =  Artist.find_or_create_by_name(artist_s)
    song_name= artist_song_genre_array[1]
    genre_s = artist_song_genre_array[2].gsub(".mp3","")
    genre = Genre.find_or_create_by_name(genre_s)
    song_info=[ song_name, artist, genre]
  end

  def self.new_from_filename (filename)
    song_info = Song.songInfo_from_file(filename)
    Song.new(song_info[0], song_info[1],  song_info[2])
  end

  def self.create_from_filename(filename)
    song = Song.new_from_filename(filename)
    song.save
    song
      #binding.pry
  end

end

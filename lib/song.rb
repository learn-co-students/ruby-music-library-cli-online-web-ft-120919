require 'pry'
require_relative './concerns/findable.rb'

class Song
  extend Concerns::Findable 

  attr_accessor :name
  attr_reader :artist, :genre
  @@all = []

  def initialize(name, artist = nil, genre = nil)
    @name = name 
    #binding.pry
    self.artist=(artist) 
    self.genre=(genre)
  end #init

  def self.create(name, artist = nil, genre = nil)
    song = self.new(name, artist, genre)
    song.save
    song 
  end #self.create

  def self.new_from_filename(filename)
    song_info = filename.split(" - ")
    song_genre = Genre.find_or_create_by_name(song_info[2][0...-4])
    song_artist = Artist.find_or_create_by_name(song_info[0])
    s = self.new(song_info[1], song_artist, song_genre)
  end #self.new_from_filename

  def self.create_from_filename(filename)
    # song_info = filename.split(" - ")
    # song_genre = Genre.find_or_create_by_name(song_info[2][0...-4])
    # song_artist = Artist.find_or_create_by_name(song_info[0])
    # s = self.create(song_info[1], song_artist, song_genre)
    song = self.new_from_filename(filename)
    song.save 
  end

  def save
    @@all << self 
  end #save

  def artist=(artist)
    @artist = artist 
    artist.add_song(self) if !artist.nil?
  end 

  def genre=(genre)
    @genre =genre
    genre.add_song(self) if !genre.nil?
  end 

  def self.all
    @@all 
  end #self.all

#   def self.find_by_name(name)
#     @@all.find{|song| song.name == name}
#   end #find_by_name

#   def self.find_or_create_by_name(name)
#     song = self.find_by_name(name)
#     if song.nil? 
#       song = Song.create(name)
#     end #if
#     song
#   end #find_or_create_by_name 

  def self.destroy_all
    @@all.clear 
  end #self.destroy_all
end 

my_song = Song.new("Somewhere over the rainbow")
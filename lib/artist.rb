require_relative './concerns/findable.rb'

class Artist
    extend Concerns::Findable

    attr_accessor :name, :songs 
    @@all = []
  
    def initialize(name)
      @name = name 
      @songs = []
    end #init
  
    def self.create(name)
      artist = self.new(name)
      artist.save
      artist 
    end
  
    def save
      @@all << self 
    end #save

    def add_song(song)
      song.artist = self if song.artist.nil?
      @songs << song if !@songs.include?(song)
    end #add_song 

    def genres
      all_genres = @songs.collect do |song|
        song.genre 
      end #collect
      all_genres.uniq 
    end #genres
  
    def self.all
      @@all 
    end #self.all
  
    def self.destroy_all
      @@all.clear 
    end #self.destroy_all
  end 
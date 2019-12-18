require_relative './concerns/findable.rb'

class Genre
    extend Concerns::Findable 
    
    attr_accessor :name, :songs 
    @@all = []
  
    def initialize(name)
      @name = name 
      @songs = []
    end #init
  
    def self.create(name)
      genre = self.new(name)
      genre.save
      genre 
    end
  
    def save
      @@all << self 
    end #save

    def add_song(song)
      song.genre = self if song.genre.nil?
      @songs << song if !@songs.include?(song)
    end #add_song 

    def artists
      all_artists = @songs.collect do |song|
        song.artist 
      end #collect
      all_artists.uniq 
    end #genres
  
    def self.all
      @@all 
    end #self.all
  
    def self.destroy_all
      @@all.clear 
    end #self.destroy_all
  end 
require "pry"
class Artist
   
    ##name-- retrieves the name of an artist
    #name= -- can set the name of an artist
    attr_accessor :name
    extend Concerns::Findable # extends the Concerns::Findable module

    # @@all  is initialized as an empty array
    @@all = []

    # #initialize --accepts a name for the new artist,  creates a 'songs' property set to an empty array (artist has many songs)
    def initialize(name)
        @name = name
        @songs = []
    end

#.all returns the class variable @@all
    def self.all
        @@all
    end

#.destroy_all --resets the @@all class variable to an empty array
    def self.destroy_all
        self.all.clear
    end

    # #save --adds the Artist instance to the @@all class variable
    def save
        @@all << self
    end

    # .create --initializes and saves the artist
    def self.create(name)
        # artist = Artist.new(name)
        # artist.save
        # artist #had to return the artist for the test to pass
        self.new(name).tap{|artist|artist.save}
    end

    # #songs-- returns the artist's 'songs' collection (artist has many songs)
    def songs
        @songs
    end

#assigns the current artist to the song's 'artist' property (song belongs to artist)
  def add_song(song)
       # song.artist = self # assigns the current artist to the song's 'artist' property (song belongs to artist)
       #@songs << song #adds the song to the current artist's 'songs' collection 
       ##does not assign the artist if the song already has an artist
       if song.artist == self
          song.artist
       else
         song.artist = self
       end 
       # does not add the song to the current artist's collection of songs if it already exists therein
      if  songs.include?(song)
         song
      else
        songs << song
      end 
      songs
    end 
#returns a collection of genres for all of the artist's songs (artist has many genres through songs)
#collects genres through its songs instead of maintaining its own @genres instance variable (artist has many genres through songs)
    def genres
        songs.collect do |song|
            song.genre
        end
        .uniq #does not return duplicate genres if the artist has more than one song of a particular genre (artist has many genres through songs)
    end
end
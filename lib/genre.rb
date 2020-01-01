require "pry"
class Genre

    ##name --retrieves the name of a genre
    #name= -- can set the name of a genre
    attr_accessor :name 
    extend Concerns::Findable #extends the Concerns::Findable module

    #@@all is initialized as an empty array
    @@all = []

# #initialize-- accepts a name for the new genre
    def initialize(name)
        @name = name 
        @songs = [] #creates a 'songs' property set to an empty array (genre has many songs)
    end
   
    #.all returns the class variable @@all
    def self.all
        @@all
    end
    
    # .destroy_all --resets the @@all class variable to an empty array
    def self.destroy_all
        self.all.clear
    end

    def save
        @@all << self
    end
#.create  initializes and saves the genre
    def self.create(name)
        # genre = Genre.new(name)
        # genre.save
        # genre #did not pass the test until genre was returned
        self.new(name).tap{|genre|genre.save}
    end 
# #songs --returns the genre's 'songs' collection (genre has many songs)
    def songs
        @songs
    end

    #returns a collection of artists for all of the genre's songs (genre has many artists through songs)
    #collects artists through its songs instead of maintaining its own @artists instance variable (genre has many artists through songs)
    def artists
        songs.collect do |song|
          song.artist
        end
        .uniq  #does not return duplicate artists if the genre has more than one song by a particular artist (genre has many artists through songs)
    end
end
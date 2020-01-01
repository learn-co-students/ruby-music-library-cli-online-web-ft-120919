require "pry"
class Song
    # #name-- retrieves the name of a song  #name= --can set the name of a song 
    ##artist  returns the artist of the song (song belongs to artist)  #artist= -- assigns an artist to the song (song belongs to artist)
attr_accessor :name, :artist, :genre 


# @@all is initialized as an empty array
@@all = []

##initialize -- accepts a name for the new song,  can be invoked with an optional second argument, an Artist object to be assigned to the song's 'artist' property (song belongs to artist), can be invoked with an optional third argument, a Genre object to be assigned to the song's 'genre' property (song belongs to genre)
  def initialize(name, artist = nil, genre = nil)
    @name = name
   # @artist = artist 
   self.artist= artist if artist  #invokes #artist= instead of simply assigning to an @artist instance variable to ensure that associations are created upon initialization 
  # @genre = genre 
  self.genre= genre if genre  # invokes #genre= instead of simply assigning to a @genre instance variable to ensure that associations are created upon initialization
  end

#.all returns the class variable @@all
  def self.all
    @@all
  end

#.destroy_all --resets the @@all class variable to an empty array
  def self.destroy_all
    self.all.clear
  end

  ##save --adds the Song instance to the @@all class variable
  def save
    @@all << self
  end

  #.create --initializes, saves, and returns the song
  def self.create(name)
#     #initializes
#     song = Song.new(name)
#     #saves
#     song.save
#     #returns
#     song
      self.new(name).tap{|song|song.save}
  end

  ##artist= invokes Artist#add_song to add itself to the artist's collection of songs (artist has many songs)
  def artist=(artist) 
    @artist = artist
    artist.add_song(self)
  end

  def genre=(genre)
    @genre = genre #assigns a genre to the song (song belongs to genre)
  # genre.songs <<  self # adds the song to the genre's collection of songs (genre has many songs) 
  #does not add the song to the genre's collection of songs if it already exists therein
    if  genre.songs.include?(self)
        genre.songs
     else
       genre.songs << self
     end
  end

  #finds a song instance in @@all by the name property of the song
  def self.find_by_name(name)
    self.all.find {|song|song.name == name}
  end

  #returns (does not recreate) an existing song with the provided name if one exists in @@all
  #creates a song if an existing match is not found
  def self.find_or_create_by_name(name)
     if song = self.find_by_name(name) #invokes .find_by_name instead of re-coding the same functionality
        song
     else
        self.create(name)  #invokes .create instead of re-coding the same functionality
     end
  end 

  # initializes a song based on the passed-in filename
  def self.new_from_filename(filename)

    artist_name, song_name, genre_name = filename.split(" - ") #mass assignment
    genre_name = genre_name.chomp(".mp3") #removes.mp3, method gsub(".mp3", "") can also be used
    #invokes the appropriate Findable methods so as to avoid duplicating objects
    song = self.find_or_create_by_name(song_name)
    
    song.artist = Artist.find_or_create_by_name(artist_name)
    
    song.genre = Genre.find_or_create_by_name(genre_name)
    song
  end

  #initializes and saves a song based on the passed-in filename
  def self.create_from_filename(filename)
    self.new_from_filename(filename).tap{|song|song.save} #invokes .new_from_filename instead of re-coding the same functionality
  end
end
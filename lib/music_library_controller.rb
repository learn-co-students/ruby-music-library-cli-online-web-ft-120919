require "pry"
class MusicLibraryController
    
    # # accepts one argument, the path to the MP3 files to be imported
    def initialize(path = "./db/mp3s") #the 'path' argument defaults to './db/mp3s'
        # creates a new MusicImporter object, passing in the 'path' value
       MusicImporter.new(path).import  #invokes the #import method on the created MusicImporter object
      
    end
    
    def call 
        input = ""
        
         while input != "exit"
        

        puts "Welcome to your music library!"
        puts "To list all of your songs, enter 'list songs'."
        puts "To list all of the artists in your library, enter 'list artists'."
        puts "To list all of the genres in your library, enter 'list genres'."
        puts "To list all of the songs by a particular artist, enter 'list artist'."
        puts "To list all of the songs of a particular genre, enter 'list genre'."
        puts "To play a song, enter 'play song'."
        puts "To quit, type 'exit'."
        puts "What would you like to do?"
        
        input = gets.strip
        case input
        when "list songs"
          list_songs
        when "list artists"
          list_artists
        when "list genres"
          list_genres
        when "list artist"
          list_songs_by_artist
        when "list genre"
          list_songs_by_genre
        when "play song"
          play_song
        end
        end
    end

    #prints all songs in the music library in a numbered list (alphabetized by song name), is not hard-coded-- had to add .uniq to remove duplicate songs
    def list_songs
    
        Song.all.sort{|a, b|a.name <=> b.name}.uniq.each_with_index{|song, index|  puts "#{index + 1}. #{song.artist.name} - #{song.name} - #{song.genre.name}"}
             
    end
  
    # prints all artists in the music library in a numbered list (alphabetized by artist name) ,  is not hard-coded
   def list_artists
      Artist.all.sort{|a, b,| a.name <=> b.name }.each_with_index{|artist, index| puts "#{index + 1}. #{artist.name}"}
   end
   
   # prints all genres in the music library in a numbered list (alphabetized by genre name), is not hard-coded
   def list_genres
      Genre.all.sort{|a, b| a.name <=> b.name}.each_with_index{|genre, index| puts "#{index + 1}. #{genre.name}"}
   end

   def list_songs_by_artist
       puts "Please enter the name of an artist:"  # prompts the user to enter an artist
       input = gets.strip # accepts user input

       # prints all songs by a particular artist in a numbered list (alphabetized by song name), does nothing if no matching artist is found
      if artist = Artist.find_by_name(input)
        artist.songs.sort{|a, b|a.name <=> b.name}.each_with_index{|song, index|  puts "#{index + 1}. #{song.name} - #{song.genre.name}"}
     end
   end

   def list_songs_by_genre
      puts "Please enter the name of a genre:"  #prompts the user to enter a genre
      input = gets.strip #accepts user input
       
      #prints all songs by a particular genre in a numbered list (alphabetized by song name), does nothing if no matching genre is found
      if genre = Genre.find_by_name(input)
          genre.songs.sort{|a, b|a.name <=> b.name}.each_with_index{|song, index|  puts "#{index + 1}. #{song.artist.name} - #{song.name}"} 
      end
   end
#prompts the user to choose a song from the alphabetized list output by #list_songs
   def play_song
      puts "Which song number would you like to play?"
      input = gets.strip.to_i #accepts user input
   
#upon receiving valid input 'plays' the matching song from the alphabetized list output by #list_songs
#checks that the user entered a number between 1 and the total number of songs in the library
#does not 'puts' anything out if a matching song is not found -- accomplished by adding uniq to if(1..Song.all.uniq.length)
      if  (1..Song.all.uniq.length).include?(input) 
         song = Song.all.sort{|a, b| a.name <=> b.name}.uniq[input-1]
         
          puts "Playing #{song.name} by #{song.artist.name}"   
         
      end
      
   end
end
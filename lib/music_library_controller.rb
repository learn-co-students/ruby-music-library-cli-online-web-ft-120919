class MusicLibraryController
  attr_accessor :path

  def initialize(path = './db/mp3s')
    @path = path
    m = MusicImporter.new(path)
    m.import 
  end #init

  def call
    user_choice = ""
    while user_choice != "exit"
        puts "Welcome to your music library!"
        puts "To list all of your songs, enter 'list songs'."
        puts "To list all of the artists in your library, enter 'list artists'."
        puts "To list all of the genres in your library, enter 'list genres'."
        puts "To list all of the songs by a particular artist, enter 'list artist'."
        puts "To list all of the songs of a particular genre, enter 'list genre'."
        puts "To play a song, enter 'play song'."
        puts "To quit, type 'exit'."
        puts "What would you like to do?"
        user_choice = gets.strip

        if user_choice == "list songs"
          list_songs
        elsif user_choice == "list artists"
          list_artists
        elsif user_choice == "list genres"
          list_genres
        elsif user_choice == "list artist"
          list_songs_by_artist 
        elsif user_choice == "list genre"
          list_songs_by_genre 
        elsif user_choice == "play song"
          play_song 
        end #if
    end #while
  end #call 

  def list_songs
    all_songs = Song.all
    all_songs.sort_by!{|song| song.name}
    all_songs.each_with_index do |song, i|
      puts "#{i+1}. #{song.artist.name} - #{song.name} - #{song.genre.name}"
    end #each
  end #list_songs 

  def list_artists
    all_artists = Artist.all
    all_artists.sort_by!{|artist| artist.name}
    all_artists.each_with_index do |artist, i|
      puts "#{i+1}. #{artist.name}"
    end #each
  end #list_artists 

  def list_genres
    all_genres = Genre.all
    all_genres.sort_by!{|genre| genre.name}
    all_genres.each_with_index do |genre, i|
      puts "#{i+1}. #{genre.name}"
    end #each
  end #list_genres

  def list_songs_by_artist
    puts "Please enter the name of an artist:"
    user_choice = gets.strip
    songs_by_artist = Song.all.select{|song| song.artist.name == user_choice}
    songs_by_artist.sort_by!{|song| song.name}
    songs_by_artist.each_with_index do |song, i|
      puts "#{i+1}. #{song.name} - #{song.genre.name}"
    end #each  
  end #list_songs_by_artist

  def list_songs_by_genre
    puts "Please enter the name of a genre:"
    user_choice = gets.strip
    songs_in_genre = Song.all.select{|song| song.genre.name == user_choice}
    songs_in_genre.sort_by!{|song| song.name}
    songs_in_genre.each_with_index do |song, i|
      puts "#{i+1}. #{song.artist.name} - #{song.name}"
    end #each  
  end #list_songs_by_genre

  def play_song
    puts "Which song number would you like to play?"
    user_choice = gets.strip.to_i
    song = Song.all.sort_by!{|song| song.name}[user_choice-1] if (user_choice > 0 && user_choice <= Song.all.length)
    puts "Playing #{song.name} by #{song.artist.name}" if !song.nil?
  end 
end #class
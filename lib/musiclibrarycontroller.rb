class MusicLibraryController
  attr_accessor :songs

  def initialize(path="./db/mp3s/")
    song_loader = MP3Importer.new(path)
    song_loader.import
    @songs=[]
  end


  def call
    #system('clear') # clears terminal
    puts "Welcome to your music library!"
    menu
  end


  def menu
    puts "To list all of your songs, enter 'list songs'."
    puts "To list all of the artists in your library, enter 'list artists'."
    puts "To list all of the genres in your library, enter 'list genres'."
    puts "To list all of the songs by a particular artist, enter 'list artist'."
    puts "To list all of the songs of a particular genre, enter 'list genre'."
    puts "To play a song, enter 'play song'."
    puts "To quit, type 'exit'."
    puts "What would you like to do?"
    menu_input
  end

  def menu_input
    user_input = gets.strip
    evaluate_main_menu_input(user_input)
  end

  def evaluate_main_menu_input(user_input)
    if user_input == "list songs"
      songs
    elsif user_input == "list artists"
      artists
    elsif user_input == "list genres"
      genres
    elsif user_input == "list artist"
      list_songs_by_artist
    elsif user_input == "list genre"
      list_songs_by_genre
    elsif user_input == "play song"
      play_song_menu
    elsif user_input == "exit"
      goodbye
    else
      incorrect_input
      menu
    end
  end

  def songs
    @songs = Song.all.sort_by do |song|
      song.name
    end
    @songs.each.with_index(1) do |song, index|
      puts "#{index}. #{song.artist} - #{song.name} - #{song.genre}"
    end
  end

  def artists
    artists = Artist.all.sort_by do |artist|
      artist.name
    end
    artists.each.with_index(1) do |artist, index|
      puts "#{index}. #{artist.name}"
    end
  end

  def genres
    genres = Genre.all.sort_by do |genre|
      genre.name
    end
    genres.each.with_index(1) do |genre, index|
      puts "#{index}. #{genre.name}"
    end
  end

  def list_songs_by_artist
    puts "Please enter the name of an artist:"
    user_input = gets.strip
    artist = Artist.find_by_name(name)
    if artist!=nil
      songs_of_artist(artist)
    end # otherwise go back to "menu" ? but "does not puts anything out"
  end
        def songs_of_artist(artist)
          songs = artist.songs.sort_by { |s | s.name }
          songs.each.with_index(1) do |song, index|
            puts "#{index}. #{song.name} - #{song.genre.name}"
          end
        end

  def list_songs_by_genre
    puts "Please enter the name of a genre:"
    user_input = gets.strip
    genre = Genre.find_by_name(name)
    if genre!=nil
      songs_by_genre(genre)
    end # otherwise go back to "menu" ? but "does not puts anything out"
  end
        def songs_by_genre(genre)
          songs = genre.songs.sort_by { |s | s.name }
          songs.each.with_index(1) do |song, index|
            puts "#{index}. #{song.name} - #{song.genre.name}"
          end
        end

  def play_song
    puts "Which song number would you like to play?"
    user_input =  gets.strip.to_i
    index = user_input-1
    song = @songs[index]
    valid = index.between[1,@songs.length]
    if song!=nil && valid
      play_selected_song(song)
    end
  end
        def play_selected_song(song) #"Playing Larry Csonka by Action Bronson"
          puts "Playing #{song.name} by #{song.artist.name}"
        end


  def goodbye
    puts 'Thank you for using the Music Library CLI Goodbye!'
    exit
  end

  def incorrect_input
    puts "Did you mean to type that? I don't understand, try again!"
  end

end
require 'pry'
class MusicLibraryController
  attr_accessor :path, :library, :songs

  def initialize(path = './db/mp3s')
    @path = path
    @library = MusicImporter.new(path)
    @songs = @library.import
  end

  def intro
    puts "Welcome to your music library!"
    puts "To list all of your songs, enter 'list songs'."
    puts "To list all of the artists in your library, enter 'list artists'."
    puts "To list all of the genres in your library, enter 'list genres'."
    puts "To list all of the songs by a particular artist, enter 'list artist'."
    puts "To list all of the songs of a particular genre, enter 'list genre'."
    puts "To play a song, enter 'play song'."
    puts "To quit, type 'exit'."
    puts "What would you like to do?"
  end

  def call
    intro
    command = nil
    until command == 'exit'
      command = gets
      case command
      when 'list songs'
        list_songs
      when 'list artists'
        list_artists
      when 'list genres'
        list_genres
      when 'list artist'
        list_songs_by_artist
      when 'list genre'
        list_songs_by_genre
      when 'play song'
        play_song
      end
    end
  end

  def sort_by_name(array)
    array.sort{ |item1, item2| item1.name <=> item2.name }
  end

  def list_songs
    count = 1
    songs = sort_by_name(Song.all)
    songs.each do |song|
      puts "#{count}. #{song.artist.name} - #{song.name} - #{song.genre.name}"
      count += 1
    end
  end

  def list_artists
    count = 1
    artists = sort_by_name(Artist.all)
    artists.each do |artist|
      puts "#{count}. #{artist.name}"
      count += 1
    end
  end

  def list_genres
    count = 1
    genres = sort_by_name(Genre.all)
    genres.each do |genre|
      puts "#{count}. #{genre.name}"
      count += 1
    end
  end

  def list_songs_by_artist
    puts 'Please enter the name of an artist:'
    artist_name = gets
    artist = Artist.find_by_name(artist_name)
    if artist
      songs = sort_by_name(artist.songs)
      count = 1
      songs.each do |song|
        puts "#{count}. #{song.name} - #{song.genre.name}"
        count += 1
      end
    end
  end

  def list_songs_by_genre
    puts 'Please enter the name of a genre:'
    genre_name = gets
    genre = Genre.find_by_name(genre_name)
    if genre
      songs = sort_by_name(genre.songs)
      count = 1
      songs.each do |song|
        puts "#{count}. #{song.artist.name} - #{song.name}"
        count += 1
      end
    end
  end

  def play_song
    puts "Which song number would you like to play?"
    song_num = gets.to_i
    songs = sort_by_name(Song.all)
    if song_num >= 1 && song_num <= songs.size
      song = songs[song_num - 1]
      puts "Playing #{song.name} by #{song.artist.name}"
    end
  end
end

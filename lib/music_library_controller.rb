require "pry"

class MusicLibraryController
  
  attr_accessor :path
  
  def initialize(path = "./db/mp3s")
    @music = MusicImporter.new(path)
    @music.import
  end
  
  def call
    puts "Welcome to your music library!"
    puts "To list all of your songs, enter 'list songs'."
    puts "To list all of the artists in your library, enter 'list artists'."
    puts "To list all of the genres in your library, enter 'list genres'."
    puts "To list all of the songs by a particular artist, enter 'list artist'."
    puts "To list all of the songs of a particular genre, enter 'list genre'."
    puts "To play a song, enter 'play song'."
    puts "To quit, type 'exit'."
    input = nil
    until input == "exit"
      puts "What would you like to do?"
      input = gets.strip
      if input == "list songs"
        list_songs
      elsif input == "list artists"
        list_artists
      elsif input == "list genres"
        list_genres
      elsif input == "list artist"
        list_songs_by_artist
      elsif input == "list genre"
        list_songs_by_genre
      elsif input == "play song"
        play_song
      end
    end
  end
  
  def song_list
    list = []
    Song.all.each {|song| list << song.name}
    list.sort
  end
  
  def list_songs
    song_list.each_with_index do |title, i|
      matched = Song.all.find {|song| song.name == title}
      puts "#{i + 1}. #{matched.artist.name} - #{title} - #{matched.genre.name}"
    end
  end
  
  def list_artists
    Artist.artist_list.sort.each_with_index do |artist, i|
      puts "#{i + 1}. #{artist}"
    end
  end

  def list_genres
    Genre.genre_list.sort.each_with_index do |genre, i|
      puts "#{i + 1}. #{genre}"
    end
  end

  def list_songs_by_artist
    puts "Please enter the name of an artist:"
    input = gets.strip
    if Artist.artist_list.include?(input)
      matched = Artist.all.find {|artist| artist.name == input}
      list = []
      matched.songs.each {|song| list << "#{song.name} - #{song.genre.name}"}
      list.sort.each_with_index {|item, i| puts "#{i + 1}. #{item}"}
    end
  end

  def list_songs_by_genre
    puts "Please enter the name of a genre:"
    input = gets.strip
    if Genre.genre_list.include?(input)
      match_a = Genre.all.find {|genre| genre.name == input}
      list = []
      match_a.songs.each {|song| list << song.name}
      list.sort.each_with_index do |title, i|
        match_b = Song.all.find {|song| song.name == title}
        puts "#{i + 1}. #{match_b.artist.name} - #{title}"
      end
    end
  end

  def play_song
    puts "Which song number would you like to play?"
    input = gets.strip
    index = input.to_i - 1
    if index > 0 and Song.all.count > index
      song = Song.all.find {|s| s.name == song_list[index]}
      puts "Playing #{song.name} by #{song.artist.name}"
    end
  end

end

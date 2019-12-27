require 'pry'

class MusicLibraryController

    def initialize(path='./db/mp3s')
        @path = path
        music_importer = MusicImporter.new(path)
        music_importer.import
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
        puts "What would you like to do?"
        user_input = ""
        while user_input != "exit"
            user_input = gets.strip 
            case user_input
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

    def list_songs 
        # binding.pry

        new_array = []
        Song.all.each { |song| new_array << song.name + ' - ' + song.artist.name + ' - ' + song.genre.name}
        sorted_array = new_array.sort 
        sorted_array.each_with_index do |file, index| 
            puts "#{index+1}. #{file.split(' - ')[1]} - #{file.split(' - ')[0]} - #{file.split(' - ')[2]}"
        end
    end

    def list_artists
        
        new_array = []
        Artist.all.each { |artist| new_array << artist.name}
        sorted_array = new_array.sort 
        sorted_array.each_with_index do |file, index| 
            puts "#{index+1}. #{file}"
        end

    end

    def list_genres
        # a = Dir.glob("#{@path}/*.mp3").collect{ |f| f.gsub("#{@path}/", "") }

        # new_array = []
        # a.each { |a| new_array << a.split(" - ")[2]}
        # sorted_array = new_array.sort.uniq
        # sorted_array.each_with_index do |file, index| 
        #     puts "#{index+1}. #{file.delete_suffix(".mp3")}"
        # end

        a = Genre.all 
        new_array = []
        Genre.all.each { |genre| new_array << genre.name}
        sorted_array = new_array.sort 
        sorted_array.each_with_index do |file, index| 
            puts "#{index+1}. #{file}"
        end
    end

    # "1. Green Aisles - country" Real Estate - Green Aisles - country // Real Estate - It's Real - hip-hop
        
    def list_songs_by_artist 
        puts "Please enter the name of an artist:"
        user_input_artist = gets.chomp
        if Artist.find_by_name(user_input_artist)
            a = Artist.find_by_name(user_input_artist)
            new_array = []
            a.songs.each { |song| new_array << song.name + " - " + song.genre.name}
            sorted = new_array.sort
            sorted.each_with_index { |list_songs, index| puts "#{index+1}. #{list_songs}" } 
        end
    end

    def list_songs_by_genre
        puts "Please enter the name of a genre:"
        user_input_genre = gets.chomp
        if Genre.find_by_name(user_input_genre)
            a = Genre.find_by_name(user_input_genre)
            new_array = []
            a.songs.each { |song| new_array << song.name + " - " + song.artist.name}
            sorted = new_array.sort
            # binding.pry
            sorted.each_with_index { |list_songs, index| puts "#{index+1}. #{list_songs.split(' - ')[1]} - #{list_songs.split(' - ')[0]}" }
        end
    end

    def play_song 
        puts "Which song number would you like to play?"
        user_input_play = gets.chomp.to_i
        if (1..Song.all.length).include?(user_input_play)
            song = Song.all.sort{|a, b| a.name <=> b.name}[user_input_play-1] 
        end
        
        puts "Playing #{song.name} by #{song.artist.name}" if song
    end




end 
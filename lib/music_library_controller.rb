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
        user_input = gets.strip until user_input == "exit"
    end

    def list_songs 
        # binding.pry
        # Song.all

        a = Dir.glob("#{@path}/*.mp3").collect{ |f| f.gsub("#{@path}/", "") }
        new_array = []
        a.each do |a| 
            new_array << a.split(' - ')
        end
        new_array.each { |b| b[0], b[1] = b[1], b[0] }
        sorted_array = new_array.sort
        sorted_array.each_with_index do |file, index| 
            puts "#{index+1}. #{file[1]} - #{file[0]} - #{file[2].delete_suffix(".mp3")}"
        end
    end

    def list_artists
        # a = Dir.glob("#{@path}/*.mp3").collect{ |f| f.gsub("#{@path}/", "") }

        # new_array = []
        # a.each { |a| new_array << a.split(" - ")[0]}
        # sorted_array = new_array.sort.uniq
        # sorted_array.each_with_index do |file, index| 
        #     puts "#{index+1}. #{file}"
        # end
        # binding.pry
        new_array = []
        Artist.all.each { |artist| new_array << artist.name}
        sorted_array = new_array.sort 
        sorted_array.each_with_index do |file, index| 
            puts "#{index+1}. #{file}"
        end

    end

    def list_genres
        a = Dir.glob("#{@path}/*.mp3").collect{ |f| f.gsub("#{@path}/", "") }

        new_array = []
        a.each { |a| new_array << a.split(" - ")[2]}
        sorted_array = new_array.sort.uniq
        sorted_array.each_with_index do |file, index| 
            puts "#{index+1}. #{file.delete_suffix(".mp3")}"
        end
    end

    def list_songs_by_artist # "1. Green Aisles - country" Real Estate - Green Aisles - country // Real Estate - It's Real - hip-hop
        puts "Please enter the name of an artist:"
        user_input_artist = gets.chomp
        
        # need to loop???? exit?
        #  a = list_songs.select { |song_artist_genre| song_artist_genre[1] ==  "Real Estate"}
        # a.each_with_index { |a, index| puts "#{index+1}. #{a[0]} - #{a[2].delete_suffix(".mp3")}"}
        # binding.pry
    end

    def list_songs_by_genre
        puts "Please enter the name of a genre:"
        user_input_genre = gets.chomp

        a = list_songs.select { |song_artist_genre| song_artist_genre[2].delete_suffix(".mp3") ==  "hip-hop"}
        a.each_with_index { |a, index| puts "#{index+1}. #{a[0]} - #{a[1]}"}
        # binding.pry

    end











end 
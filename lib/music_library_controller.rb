class MusicLibraryController
    def initialize(path = "./db/mp3s")
        new_importer_object = MusicImporter.new(path)
        new_importer_object.import
    end

    def call
        user_input = ""
        while user_input != "exit"
            puts "Welcome to your music library!"
            puts "To list all of your songs, enter 'list songs'."
            puts "To list all of the artists in your library, enter 'list artists'."
            puts "To list all of the genres in your library, enter 'list genres'."
            puts "To list all of the songs by a particular artist, enter 'list artist'."
            puts "To list all of the songs of a particular genre, enter 'list genre'."
            puts "To play a song, enter 'play song'."
            puts "To quit, type 'exit'."
            puts "What would you like to do?"
            
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
        sorted_song_array = Song.all.sort{|a, b| a.name <=> b.name}
        sorted_song_array.each.with_index(1) do |song_object, index|
            puts "#{index}. #{song_object.artist.name} - #{song_object.name} - #{song_object.genre.name}"
        end
    end

    def list_artists
        sorted_artist_array = Artist.all.sort{|a, b| a.name <=> b.name}
        sorted_artist_array.each.with_index(1) do |artist_object, index|
            puts "#{index}. #{artist_object.name}"
        end
    end

    def list_genres
        sorted_genre_array = Genre.all.sort{|a, b| a.name <=> b.name}
        sorted_genre_array.each.with_index(1) do |genre_object, index|
            puts "#{index}. #{genre_object.name}"
        end
    end

    def list_songs_by_artist
        puts "Please enter the name of an artist:"
        user_artist_input = gets.strip
        if user_artist_object = Artist.find_by_name(user_artist_input)
            user_artist_songs_sorted_array = user_artist_object.songs.sort{|a, b| a.name <=> b.name}
            user_artist_songs_sorted_array.each.with_index(1) do |song_object, index|
                puts "#{index}. #{song_object.name} - #{song_object.genre.name}"
            end
        end
    end

    def list_songs_by_genre
        puts "Please enter the name of a genre:"
        user_genre_input = gets.strip
        if user_genre_object = Genre.find_by_name(user_genre_input)
            user_genre_songs_sorted_array = user_genre_object.songs.sort{|a, b| a.name <=> b.name}
            user_genre_songs_sorted_array.each.with_index(1) do |song_object, index|
                puts "#{index}. #{song_object.artist.name} - #{song_object.name}"
            end
        end
    end

    def play_song
        puts "Which song number would you like to play?"
        song_list = Song.all.sort{|a, b| a.name <=> b.name}
        user_song_choice = gets.strip.to_i
        if (1..song_list.length).include?(user_song_choice)
            song_choice = song_list[user_song_choice - 1]
            puts "Playing #{song_choice.name} by #{song_choice.artist.name}"
        end
    end
end
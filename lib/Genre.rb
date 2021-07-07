class Genre
    attr_accessor :name
    extend Concerns::Findable
    
    @@all = []

    def initialize(name)
        @name = name 
        @songs = []
    end 

    def self.all
        @@all
    end 

    def self.destroy_all
        @@all = []
    end 

    def save
        @@all << self 
    end 

    def self.create(new_genre)
        genre = self.new(new_genre)
        genre.save
        genre 
    end 

    def songs
        @songs
    end

    def artists
        @new_array = []
        @songs.each do |song|
          if @new_array.include?(song.artist)
            nil
          else
            @new_array << song.artist
          end
        end
        @new_array
      end
end 
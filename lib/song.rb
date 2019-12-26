require 'pry'

class Song

    attr_accessor :name

    @@all = []

    def initialize(name, artist=nil)
        @name = name 
        @artist = artist
        save
    end

    def self.all
        @@all
    end

    def self.destroy_all
        @@all.clear
    end

    def save
        @@all << self
    end

    def self.create(name)
        song = self.new(name)
    end
    
    def artist
        @artist
    end
end
module Concerns::Findable
    def self.find_by_name(name)
        @@all.detect do |object|
            object.name == name
        end
    end
end
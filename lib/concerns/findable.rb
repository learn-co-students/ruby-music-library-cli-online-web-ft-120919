module Concerns::Findable
    def find_by_name(name)
        self.all.find do |x|
        x.name == name 
    end

    end

    def find_or_create_by_name(name)
        self.find_by_name(name) || self.create(name) #if that's not true, this is -- with a method!
    end   
end
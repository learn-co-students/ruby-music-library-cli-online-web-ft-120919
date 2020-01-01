#defines a module named Concerns::Findable

module Concerns::Findable
    # Module code here

    # .find_by_name  is added as a class method to classes that extend the module,  isn't hard-coded
   # works exactly like a generic version of Song.find_by_name, searching the extended class's @@all variable for an instance that matches the provided name
    def find_by_name(name)
        self.all.find {|object|object.name == name}
    end
    

    #.find_or_create_by_name is added as a class method to classes that extend the module
   # works exactly like a generic version of Song.find_or_create_by_name: finds (does not recreate) an existing instance with the provided name if one exists in @@all
     # isn't hard-coded, invokes .find_by_name instead of re-coding the same functionality
     # invokes the extended class's .create method, passing in the provided name, if an existing match is not found
    def find_or_create_by_name(name)
        if song = self.find_by_name(name) #invokes .find_by_name instead of re-coding the same functionality
           song
        else
           self.create(name)  #invokes .create instead of re-coding the same functionality
        end
     end
  end
require 'bundler'
Bundler.require

# Upon Advice from Ms.  Neff at 11:15 PM 1/12/2019
module Concerns
  module Findable
    def find_by_name(name)
      self.all.detect {|object| object.name == name}
    end

    def find_or_create_by_name(name)
      found = self.find_by_name(name)
      if found==nil
        self.create(name)
      else
        found
      end
    end
  end
end


require_all 'lib'


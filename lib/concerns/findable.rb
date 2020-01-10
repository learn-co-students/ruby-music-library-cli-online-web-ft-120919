module Concerns
  module Findable
    def find_by_name(name)
      all.detect{|item| item.name == name}
    end

    def find_or_create_by_name(name)
      found = self.find_by_name(name)
      found ? found : create(name)
    end
  end
end
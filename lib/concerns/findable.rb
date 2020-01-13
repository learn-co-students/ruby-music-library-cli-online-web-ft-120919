module Concerns::Findable

  def self.find_by_name(name)
    self.class.all.detect{|o| o.name == name}
  end

  def self.find_or_create_by_name (name)
    found = find_by_name(name)
    if (!found)
      self.class.create(name)
    end
    return found
  end
end
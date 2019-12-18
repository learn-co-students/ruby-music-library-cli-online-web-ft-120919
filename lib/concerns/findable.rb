module Concerns::Findable

  def find_by_name(name)
    all.find{|song| song.name == name}
  end #find_by_name

  def find_or_create_by_name(name)
    obj = self.find_by_name(name)
    if obj.nil? 
      obj = self.create(name)
    end #if
    obj 
  end #find_or_create_by_name 
  
end #module
class Class

  def uses (trait)
    trait.metodos.each {|key, value|
      unless self.instance_methods(false).include? key
      define_method key, value
      end
      }
    nil

  end

end
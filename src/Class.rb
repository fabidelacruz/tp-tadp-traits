class Class

  def uses (trait)

   trait.metodos.each {|key, value| define_method key, value }
    nil

  end

end
class Class

  def uses (trait)

    instanciaTrait = trait.new
    instanciaTrait.methods.each do |nombre|

      unless self.instance_methods.include? nombre
        bloque = instanciaTrait.method(nombre).to_proc
        define_method nombre, bloque
      end
    end

    nil

  end

end
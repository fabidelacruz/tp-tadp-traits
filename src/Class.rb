class Class

  def uses (trait)

    trait.methods.each do |nombre|

      unless self.instance_methods.respond_to?(nombre)
        block = trait.method(nombre).to_proc
        define_method(nombre, block)
      end
    end

    nil

  end

end
class Trait

  def self.define (&proc)
    # Creo una nueva Clase que herede de trait
    nuevoTrait= Class.new(Trait)
    #Ahora tengo que usar el class_eval en vez del instance porque ahora tengo otra clase
    nuevoTrait.class_eval &proc

  end

  def self.name (sym)
    Object.const_set(sym, self.new)
  end

  def self.method (sym, &block)
    define_method(sym, &block)
  end

end

class Class

  def uses (trait)

    trait.class.instance_methods.each do |nombre|

      unless self.instance_methods.include?(nombre)
        block = trait.method(nombre).to_proc
        define_method(nombre, block)
      end
    end

    nil

  end

end


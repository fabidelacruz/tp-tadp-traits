class Trait

  alias :metodos :method

  def self.define (&block)

    self.new.instance_eval &block

  end

  def name (sym)
    Object.const_set(sym, self) #Creo una constante para referir al trait
  end

  def method (sym, &block)
    self.define_singleton_method(sym, &block) #Agrego un método al trait
  end

end

class Class

  def uses (trait)

    trait.methods.each do |nombre|

      unless self.instance_methods.include?(nombre)
        block = trait.metodos(nombre).to_proc
        define_method(nombre, block)
      end
    end

    nil

  end

end


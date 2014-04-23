class Class

  def uses (trait)

    trait.methods.each do |nombre|

      unless self.instance_methods.include?(nombre)
        block = trait.method(nombre).to_proc
        define_method(nombre, block)
      end
    end

    nil

  end

end

class Trait

  def self.define (&block)

    self.new.instance_eval &block

  end

  def + (otroTrait)

    trait = Trait.new

    if hay_metodos_iguales(otroTrait)
      self.lanzar_error_suma
    else
      trait.sumar_metodos self
      trait.sumar_metodos otroTrait
    end

    trait
  end

  def - (unMetodo)

    trait = Trait.new
    trait.restar_metodos self, unMetodo

  end

  def sumar_metodos (trait)
    trait.methods(false).each { |metodo| self.definir_metodo_singleton(trait, metodo) }
  end

  def restar_metodos (trait, unMetodo)
    trait.methods(false).each { |metodo| unless metodo==unMetodo
                                           self.definir_metodo_singleton(trait, metodo)
                                         end
    }
    self
  end

  def definir_metodo_singleton (trait, metodo)
    self.define_singleton_method(metodo, trait.method(metodo).to_proc)
  end

  def hay_metodos_iguales(otroTrait)
    otroTrait.methods(false).any? { |metodo|
      if self.methods(false).include?(metodo) then self.lanzar_error_suma end}
  end

  def lanzar_error_suma
    raise 'Existen 2 metodos con el mismo nombre'
  end

  private
  def nombre (sym)
    Object.const_set(sym, self) #Creo una constante para referir al trait
  end

  private
  def metodo (sym, &block)
    self.define_singleton_method(sym, &block) #Agrego un método al trait
  end



end

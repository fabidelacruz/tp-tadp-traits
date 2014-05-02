class Trait

  def self.define &block

    self.new.instance_eval &block

  end

  #private --Los metodos privados los declaro debajo
  def nombre sym
    Object.const_set sym, self #Creo una constante para referir al trait
  end

  #private
  def metodo sym, &block
    self.define_singleton_method sym, &block #Agrego un método al trait
  end

  def + otroTrait

    trait = Trait.new

    trait.sumar_metodos self
    trait.sumar_metodos otroTrait

    trait
  end

  def - unMetodo

    trait = Trait.new
    trait.agregar_metodos_excepto_uno self, unMetodo

  end

  def << renombreSelector

    self.singleton_class.send(:alias_method, renombreSelector[1], renombreSelector[0])
    self
  end

  def sumar_metodos trait
    bloqueError = lambda { raise 'Existen 2 metodos con el mismo nombre' }
    self.agregar_metodos trait, lambda{ |metodo| if self.methods(false).include? metodo then
                                           self.define_singleton_method metodo, &bloqueError
                                         else
                                           self.definir_metodo_singleton trait, metodo
                                         end }
  end

  def agregar_metodos_excepto_uno trait, unMetodo
     self.agregar_metodos trait, lambda{ |metodo| self.definir_metodo_singleton trait, metodo unless metodo==unMetodo }
    self
  end

  def agregar_metodos trait, bloque
    trait.methods(false).each &bloque
  end

  def definir_metodo_singleton trait, metodo
    self.define_singleton_method metodo, trait.method(metodo).to_proc
  end

  private :nombre, :metodo

end

class Trait

  def self.define &block

    self.clone.instance_eval &block

  end

  def self.nombre sym
    Object.const_set sym, self #Creo una constante para referir al trait
  end

  def self.metodo sym, &block
    define_method sym, &block #Agrego un método al trait
  end

  def self.+ otroTrait

    trait = Trait.clone

    trait.sumar_metodos self
    trait.sumar_metodos otroTrait

    trait
  end

  def self.- unMetodo

    trait = Trait.clone
    trait.agregar_metodos_excepto_uno self, unMetodo

  end

  def self.<<

  end

  def self.sumar_metodos trait
    bloqueError = lambda { raise 'Existen 2 metodos con el mismo nombre' }
    self.agregar_metodos trait, lambda{ |metodo| if self.instance_methods(false).include? metodo then
                                           define_method metodo, &bloqueError
                                         else
                                           self.definir_metodo trait, metodo
                                         end }
  end

  def self.agregar_metodos_excepto_uno trait, unMetodo
     self.agregar_metodos trait, lambda{ |metodo| self.definir_metodo trait, metodo unless metodo==unMetodo }
    self
  end

  def self.agregar_metodos trait, bloque
    trait.instance_methods(false).each &bloque
  end

  def self.definir_metodo trait, metodo
    instanciaTrait = trait.new
    define_method metodo, instanciaTrait.method(metodo).to_proc
  end

end

class Trait

  def self.define &block

    self.new.instance_eval &block

  end

  #private --Los metodos privados se declaran debajo
  def nombre sym
    Object.const_set sym, self #Se crea una constante para referir al trait
  end

  #private
  def metodo sym, &block
    self.define_singleton_method sym, &block #Se agrega un metodo al trait
  end

  def + otroTrait #Se crea un nuevo trait que tiene los metodos propios (trait que recibe el mensaje) y los correspondientes al trait que se recibe por parametro

    trait = Trait.new

    trait.sumar_metodos self
    trait.sumar_metodos otroTrait

    trait
  end

  def - unMetodo #Se crea un nuevo trait que tiene los metodos del trait que recibe el mensaje exceptuando el metodo que viene por parametro

    trait = Trait.new
    trait.agregar_metodos_excepto_uno self, unMetodo

  end

  def << renombreSelector #Se renombra el selector  en el hash de un metodo para evitar conflictos

    self.singleton_class.send(:alias_method, renombreSelector[1], renombreSelector[0])
    self
  end

  def sumar_metodos trait # Se agregan los metodos del trait que se recibe por parametro y se devuelve un codigo de error si
                          # ya existe uno con el mismo nombre
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

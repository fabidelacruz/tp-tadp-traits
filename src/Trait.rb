class Trait

  attr_accessor :metodos

  def initialize(metodos = Hash.new)
    self.metodos = metodos
  end

  def self.define &block
    self.new.instance_eval &block
  end

  #private --Los metodos privados se declaran debajo
  def nombre sym
    Object.const_set sym, self #Se crea una constante para referir al trait
  end

  #private
  def metodo sym, &block
<<<<<<< HEAD
    self.define_singleton_method sym, &block #Se agrega un metodo al trait
  end

  def + otroTrait #Se crea un nuevo trait que tiene los metodos propios (trait que recibe el mensaje) y los correspondientes al trait que se recibe por parametro

    trait = Trait.new

    trait.sumar_metodos self
    trait.sumar_metodos otroTrait

    trait
  end

  def - unMetodo #Se crea un nuevo trait que tiene los metodos del trait que recibe el mensaje exceptuando el metodo que viene por parametro
=======
    @metodos[sym] = block #Agrego un método al trait
  end

  def + otroTrait
    TraitCompuesto.new.union_de_metodos!(self).union_de_metodos!(otroTrait)
  end

  def - unMetodo
    Trait.new(self.resta_de_metodos(unMetodo))
  end
>>>>>>> origin/solucion_con_hash

  def resta_de_metodos(un_metodo)
    self.metodos.reject {|symbol, bloque| symbol == un_metodo}
  end

<<<<<<< HEAD
  def << renombreSelector #Se renombra el selector  en el hash de un metodo para evitar conflictos
=======
  def << renombreSelector
    nuevo_trait = Trait.new(self.metodos.clone)
    nuevo_trait.agregar_alias!(renombreSelector)
  end
>>>>>>> origin/solucion_con_hash

  def agregar_alias!(renombreSelector)
    self.metodos[renombreSelector[1]] = self.metodos[renombreSelector[0]]
    self
  end

<<<<<<< HEAD
  def sumar_metodos trait # Se agregan los metodos del trait que se recibe por parametro y se devuelve un codigo de error si
                          # ya existe uno con el mismo nombre
    bloqueError = lambda { raise 'Existen 2 metodos con el mismo nombre' }
    self.agregar_metodos trait, lambda{ |metodo| if self.methods(false).include? metodo then
                                                   self.define_singleton_method metodo, &bloqueError
                                                 else
                                                   self.definir_metodo_singleton trait, metodo
                                                 end }
=======
  def get_metodo(selector)
    self.metodos[selector]
  end

  def metodos_definidos
    self.metodos.keys
>>>>>>> origin/solucion_con_hash
  end

  private :nombre, :metodo

end


class TraitCompuesto < Trait

  def union_de_metodos!(otro_trait)
    metodos_envueltos = Hash.new
    otro_trait.metodos.each{ |key,value| metodos_envueltos[key]=[value].flatten}
    self.metodos.merge!(metodos_envueltos){|key, old, new| old+new}
    self
  end

  def - (un_metodo)
    TraitCompuesto.new(self.resta_de_metodos(un_metodo))
  end

  def << renombreSelector
    nuevo_trait = TraitCompuesto.new(self.metodos.clone)
    nuevo_trait.agregar_alias!(renombreSelector)
  end

  def get_metodo(selector)
    if(self.metodos[selector].length == 1)
      super[0]
    else
      lambda{|*args| raise ConflictError.new 'Conflicto generado con el metodo'+selector.to_s}
    end
  end

  def get_metodos(selector)
    self.metodos[selector]
  end

end

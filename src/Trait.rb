class Trait

  attr_accessor :metodos

  def initialize(metodos = Hash.new)
    self.metodos = metodos
  end

  def self.define &block
    self.new.instance_eval &block
  end

  #private --Los metodos privados los declaro debajo
  def nombre sym
    Object.const_set sym, self #Creo una constante para referir al trait
  end

  #private
  def metodo sym, &block
    @metodos[sym] = block #Agrego un método al trait
  end

  def + otroTrait
    TraitCompuesto.new.union_de_metodos!(self).union_de_metodos!(otroTrait)
  end

  def - unMetodo
    Trait.new(self.resta_de_metodos(unMetodo))
  end

  def resta_de_metodos(un_metodo)
    self.metodos.reject {|symbol, bloque| symbol == un_metodo}
  end

  def << renombreSelector
    nuevo_trait = Trait.new(self.metodos.clone)
    nuevo_trait.agregar_alias!(renombreSelector)
  end

  def agregar_alias!(renombreSelector)
    self.metodos[renombreSelector[1]] = self.metodos[renombreSelector[0]]
    self
  end

  def get_metodo(selector)
    self.metodos[selector]
  end

  def metodos_definidos
    self.metodos.keys
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
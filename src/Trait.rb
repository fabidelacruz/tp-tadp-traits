class Trait

  attr_accessor :metodos, :ancestros

  def initialize
    self.metodos = Hash.new
  end

  def self.crear_con_ancestros (unAncsetro, otroAncestro)
    nuevo = self.new
    nuevo.ancestros = []
    nuevo.ancestros << unAncsetro
    nuevo.ancestros << otroAncestro
    nuevo
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
    trait = Trait.crear_con_ancestros self, otroTrait
    trait.metodos = self.metodos.merge(otroTrait.metodos)  {|key, old, new| lambda{raise 'Error'}}
    trait
  end

  def - unMetodo
    trait = Trait.new
    trait.metodos = self.metodos.reject {|key,value| key == unMetodo}
    trait
  end

  def << renombreSelector
    nuevo_trait = self.clone
    nuevo_trait.metodos[renombreSelector[1]] = nuevo_trait.metodos[renombreSelector[0]]
    nuevo_trait
  end

  private :nombre, :metodo

end

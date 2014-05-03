class Trait

  attr_accessor :metodos, :metodos_ancestros

  def initialize
    self.metodos = Hash.new
    self.metodos_ancestros = Hash.new
  end

  def self.crear_con_ancestros (unAncsetro, otroAncestro)
    nuevo = self.new
    nuevo.agregar_metodos_ancestros unAncsetro.metodos
    nuevo.agregar_metodos_ancestros otroAncestro.metodos
    nuevo
  end

  def agregar_metodos_ancestros(metodos)
    self.metodos_ancestros.merge!(metodos) { |key, old, new| if old != new then [old, new].flatten else old end }
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
    trait.metodos = self.metodos.merge(otroTrait.metodos)  {|symbol, unBloque, otroBloque| lambda{raise ConflictError.new 'Conflicto generado con el metodo #{symbol}'}}
    trait
  end

  def - unMetodo
    trait = Trait.new
    trait.metodos = self.metodos.reject {|symbol, bloque| symbol == unMetodo}
    trait
  end

  def << renombreSelector
    nuevo_trait = self.clone
    nuevo_trait.metodos[renombreSelector[1]] = nuevo_trait.metodos[renombreSelector[0]]
    nuevo_trait
  end

  private :nombre, :metodo

end

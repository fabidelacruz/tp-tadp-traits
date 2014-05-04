class Trait

  attr_accessor :metodos, :metodos_ancestros

  def initialize(metodos = Hash.new, metodos_ancestros = Hash.new)
    self.metodos = metodos
    self.metodos_ancestros = metodos_ancestros
  end

  def self.crear_con_ancestros (unAncestro, otroAncestro)
    self.new(unAncestro.union_de_metodos(otroAncestro)).agregar_metodos_ancestros!(unAncestro).agregar_metodos_ancestros!(otroAncestro)
  end

  def agregar_metodos_ancestros!(unAncestro)
    self.metodos_ancestros.merge!(unAncestro.metodos) { |key, old, new| if old != new then [old, new].flatten else old end }
    self
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
    Trait.crear_con_ancestros self, otroTrait
  end

  def union_de_metodos otro_trait
    self.metodos.merge(otro_trait.metodos) {|symbol, unBloque, otroBloque| lambda{raise ConflictError.new 'Conflicto generado con el metodo #{symbol}'}}
  end

  def - unMetodo
    Trait.new(self.resta_de_metodos(unMetodo), self.metodos_ancestros)
  end

  def resta_de_metodos(un_metodo)
    self.metodos.reject {|symbol, bloque| symbol == un_metodo}
  end

  def << renombreSelector
    nuevo_trait = self.clone
    nuevo_trait.metodos[renombreSelector[1]] = nuevo_trait.metodos[renombreSelector[0]]
    nuevo_trait
  end

  private :nombre, :metodo

end

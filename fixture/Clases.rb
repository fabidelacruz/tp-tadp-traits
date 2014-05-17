require '../src/Trait'
require '../src/Class'
require '../src/Symbol'
require '../src/estrategia_solucion_conflicto'
require '../fixture/Traits'

class ClasePrueba
  uses UnTrait

  def m1
    1
  end
end

class ClasePruebaDos
  uses OtroTrait
end

class TodoBienTodoLegal
  uses OtroTrait + (TraitSelector - :metodoSelector)
end
class UnaClase
  uses UnTrait + MetodoRepetido
end

class ConAlias
  uses OtroTrait << (:metodoAlias > :saludo)
end

class ConAlias2
  uses OtroTrait << (:metodoAlias > :saludo2)
end

class ConEstrategiaIterativa
  agregar_estrategia(EstrategiaIterativa.new(:sumar_energia))
  uses TraitModificador+TraitCambiador

  def initialize(numero = 0)
    self.energia = numero
  end

  attr_accessor :energia
end

class ConEstrategiaFoldeable
  agregar_estrategia(EstrategiaFoldeable.new(:get_precio, &Proc.new{|acumulador, valor| acumulador + valor}))
  uses TraitReal+TraitExagerado
end

class ConEstrategiaCondicional
  agregar_estrategia(EstrategiaCondicional.new(:get_precio, &Proc.new{|valor| valor > 500}))
  uses TraitReal+TraitExagerado
end

class EstrategiaCantidad < EstrategiaSolucionConflicto
  def solucion_conflicto(obj, metodos, *args)
    metodos.size
  end
end

class ConEstrategiaCantidad
  agregar_estrategia(EstrategiaCantidad.new(:metodoSaludo))
  uses UnTrait+MetodoRepetido
end

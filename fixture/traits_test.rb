require '../src/Trait'
require '../src/Class'
require '../src/Symbol'
require '../src/estrategia_solucion_conflicto'

Trait.define do

  nombre :UnTrait

  metodo :metodoSaludo do
    "Hola Mundo"
  end

  metodo :m1 do
    23
  end
end

Trait.define do
  nombre :OtroTrait

  metodo :wow do
    42
  end

  metodo :metodoSelector do
    "Hola OtroTrait"
  end

  metodo :metodoAlias do
    "Hola"
  end

end

Trait.define do
  nombre :MetodoRepetido

  metodo :metodoSaludo do
    20
  end
end

Trait.define do
  nombre :TraitSelector

  metodo :metodoMundo do
    "mundo"
  end

  metodo :metodoSelector do
    "Hola Selector"
  end

end

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

Trait.define do
  nombre :TraitModificador

  metodo :sumar_energia do |numero|
    self.energia= self.energia+numero
  end

  metodo :get_numero do
    7
  end
end

Trait.define do
  nombre :TraitCambiador

  metodo :sumar_energia do |numero|
    self.energia= self.energia+numero*3
  end

end

Trait.define do
  nombre :TraitExagerado

  metodo :get_precio do
    1000
  end
end

Trait.define do
  nombre :TraitReal

  metodo :get_precio do
    15
  end
end

Trait.define do
  nombre :TraitMuyExagerado

  metodo :get_precio do
    1000000
  end
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

require '../src/Trait'
require '../src/Class'
require '../src/Symbol'

Trait.define do

  nombre :UnTrait

  metodo :metodoSaludo do
    "Hola Mundo"
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

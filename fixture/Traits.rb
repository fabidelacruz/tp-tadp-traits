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
require 'rspec'
require File.expand_path('../src/clase_trait')

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

describe 'Test Traits' do

  it 'Agregar un trait a una clase y ejecutar un metodo provisto por el trait' do

    var = ClasePrueba.new
    var.metodoSaludo.should == "Hola Mundo"

  end

  it 'Los métodos solamente se aplican a la clase correspondiente' do
    obj = ClasePruebaDos.new
    obj.wow.should == 42
    expect {
      obj.metodoSaludo.should == "Hola Mundo"
    }.to raise_error NoMethodError

  end

  it 'Sumar dos traits que tienen métodos con el mismo nombre da error' do

    expect {
      class UnaClase
        uses UnTrait + MetodoRepetido
      end
    }.to raise_error RuntimeError
  end

  it 'Sumar dos trait que tienen metodos diferentes' do
    class Prueba
      uses UnTrait + OtroTrait
    end

    obj = Prueba.new
    obj.metodoSaludo.should == "Hola Mundo"
    obj.wow.should == 42
  end

  it 'Resta de selectores' do

    o = TodoBienTodoLegal.new
    o.wow.should == 42
    o.metodoMundo.should == "mundo"
    o.metodoSelector.should == "Hola OtroTrait"

  end

end
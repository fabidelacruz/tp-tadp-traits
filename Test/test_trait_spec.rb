require 'rspec'
require '../src/conflict_error'
require '../fixture/traits_test'

describe 'Test Traits' do

  it 'Agregar un trait a una clase y ejecutar un metodo provisto por el trait' do

    var = ClasePrueba.new
    var.metodoSaludo.should == "Hola Mundo"

  end

  it 'El comportamiento provisto por la clase tiene prioridad sobre el comportamiento birndado por el trait' do
    ClasePrueba.new.m1.should == 1
  end

  it 'Los metodos solamente se aplican a la clase correspondiente' do
    obj = ClasePruebaDos.new
    obj.wow.should == 42
    expect {
      obj.metodoSaludo.should == "Hola Mundo"
    }.to raise_error NoMethodError

  end

  it 'Sumar dos traits que tienen metodos con el mismo nombre da error' do

    expect {
      unObj = UnaClase.new
      unObj.metodoSaludo
    }.to raise_error ConflictError
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

  it 'Renombrar selectores' do

    o = ConAlias.new
    o.saludo.should == "Hola"
    o.metodoAlias.should == "Hola"
    o.wow.should == 42

  end

  it 'Al sumar dos traits que contengan el metodoSaludo la cantidad de metodos ancestros para ese selector son 2'do
    (UnTrait+MetodoRepetido).metodos_ancestros[:metodoSaludo].size.should == 2
  end

end
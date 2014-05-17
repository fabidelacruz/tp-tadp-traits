require 'rspec'
require '../src/conflict_error'
require '../fixture/Clases'

describe 'Test Traits' do

  it 'Agregar un trait a una clase y ejecutar un metodo provisto por el trait' do

    var = ClasePrueba.new
    var.metodoSaludo.should == "Hola Mundo"

  end

<<<<<<< HEAD
  it 'Los metodos que provee un trait solamente se aplican a la clase que lo usa y no a otra' do
=======
  it 'El comportamiento provisto por la clase tiene prioridad sobre el comportamiento birndado por el trait' do
    ClasePrueba.new.m1.should == 1
  end

  it 'Los metodos solamente se aplican a la clase correspondiente' do
>>>>>>> origin/solucion_con_hash
    obj = ClasePruebaDos.new
    expect {
      obj.metodoSaludo.should == "Hola Mundo"
    }.to raise_error NoMethodError

  end

  it 'Sumar dos traits que tienen metodos con el mismo nombre da error' do
    unObj = UnaClase.new
    expect {unObj.metodoSaludo}.to raise_error ConflictError
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
  end

  it 'Al sumar dos traits que contengan el sumar_energia y tiene Estrategia Iterativa debe llamar a los dos metodos' do
    obj = ConEstrategiaIterativa.new
    obj.sumar_energia 2
    obj.energia.should == 8
  end

  it 'Al sumar dos traits que contengan el get_numero y tiene Estrategia Foldeable debe retornar la suma de los retornos'do
    obj = ConEstrategiaFoldeable.new
    obj.get_precio.should == 1015
  end

  it 'Al sumar TraitReal, TraitExagerado, TraitMuyExagerado y usar Estrategia condicional >500 get_precio retorna 1000'do
    obj = ConEstrategiaCondicional.new
    obj.get_precio.should == 1000
  end

  it 'Al heredar de EstrategiaSolucionConflicto puedo crear una estrategia que retorne la cantidad de metodos con mismo nombre que obtuve por traits'do

    obj = ConEstrategiaCantidad.new
    obj.metodoSaludo.should == 2

  end

end
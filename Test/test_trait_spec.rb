require 'rspec'
require File.expand_path('../src/clase_trait')

Trait.define do

  name :UnTrait

  method :metodo do
    "Hola Mundo"
  end

end

Trait.define do
  name :OtroTrait

  method :wow do
    42
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

describe 'Test Traits' do

  it 'Agregar un trait a una clase y ejecutar un metodo provisto por el trait' do

    var = ClasePrueba.new
    var.metodo.should == "Hola Mundo"

  end

  it 'Los métodos solamente se aplican a la clase correspondiente' do
    obj = ClasePruebaDos.new
    obj.wow.should == 42
    expect {
        obj.should == "Hola Mundo"
    }.to raise_error NoMethodError

  end

end
require 'rspec'
require File.expand_path('../src/clase_trait')

Trait.define do

  name :UnTrait

  method :metodo do
    "Hola Mundo"
  end

end

class ClasePrueba
  uses UnTrait

  def m1
    1
  end
end

describe 'Test Traits' do

  it 'Agregar un trait a una clase y ejecutar un metodo provisto por el trait' do

    var = ClasePrueba.new
    var.metodo.should == "Hola Mundo"

  end
end
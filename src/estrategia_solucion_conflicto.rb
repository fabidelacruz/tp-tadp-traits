class EstrategiaSolucionConflicto
  attr_accessor :metodo_asociado

  def initialize(metodo_asociado)
    self.metodo_asociado = metodo_asociado
  end

  def solucionas_a? selector
    self.metodo_asociado == selector
  end

  def metodo_solucionador_conflicto trait
    estrategia = self
    Proc.new do |*args|
      begin
        estrategia.ejecutar_metodo(self, trait.get_metodo(estrategia.metodo_asociado), *args)
      rescue ConflictError
        estrategia.solucion_conflicto(self, trait.get_metodos_ancestros(estrategia.metodo_asociado), *args)
      end
    end
  end

  def solucion_conflicto(obj, metodos, *args)
    raise "Debe definir solucion_conflicto o heredar de las estrategias ya creadas"
  end

  def ejecutar_metodo(obj, metodo, *args)
    obj.instance_exec(*args, &metodo)
  end

end

class EstrategiaIterativa < EstrategiaSolucionConflicto
  def solucion_conflicto(obj, metodos, *args)
    metodos.each do |metodo|
      self.ejecutar_metodo(obj, metodo, *args)
    end
  end
end

class EstrategiaFoldeable < EstrategiaSolucionConflicto
  attr_accessor :funcion

  def initialize(metodo_asociado, &funcion)
    super(metodo_asociado)
    self.funcion = funcion
  end

  def solucion_conflicto(obj, metodos, *args)
    metodos.each do |metodo|
      if(@acumulador.nil?)
        @acumulador = self.ejecutar_metodo(obj, metodo, *args)
      else
        @acumulador = self.funcion.call(@acumulador, self.ejecutar_metodo(obj,metodo,*args))
      end
    end
    @acumulador
  end
end

class EstrategiaCondicional < EstrategiaSolucionConflicto
  attr_accessor :condicion

  def initialize(metodo_asociado, &condicion)
    super(metodo_asociado)
    self.condicion = condicion
  end

  def solucion_conflicto(obj, metodos, *args)
    metodos.each do |metodo|
      resultado = self.ejecutar_metodo(obj, metodo, *args)
      if(self.condicion.call(resultado))
        return resultado
      end
    end
  end
end
class Class

  def uses (trait)
    trait.metodos.each {|key, value|
      unless self.instance_methods(false).include? key
        if(@estrategias and self.estrategia_para? key)
          bloque = self.estrategia_para!(key).metodo_solucionador_conflicto(trait)
        else
          bloque = value
        end
        define_method key, bloque
      end
      }
    nil

  end

  def agregar_estrategia estrategia
    @estrategias = @estrategias || []
    @estrategias << estrategia
  end

  def estrategia_para? selector
    @estrategias.any? {|estrategia| estrategia.solucionas_a? selector}
  end

  def estrategia_para! selector
    @estrategias.find {|estrategia| estrategia.solucionas_a? selector}
  end

end
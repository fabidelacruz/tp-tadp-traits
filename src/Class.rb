class Class

  def uses (trait)
    trait.metodos_definidos.each {|selector|
      unless self.instance_methods(false).include? selector
        if(@estrategias and self.estrategia_para? selector)
          bloque = self.estrategia_para!(selector).metodo_solucionador_conflicto(trait)
        else
          bloque = trait.get_metodo(selector)
        end
        define_method selector, bloque
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
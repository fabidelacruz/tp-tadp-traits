class Trait

  protected def + (unTrait)

  end

  protected def - (unTrait)

  end

  def self.define (&proc)

    instance_eval &proc

  end

  def self.name (sym)
    Object.const_set(sym, self.new)
  end

  def self.method (sym, &block)
    define_method(sym, &block)
  end

end

class Class

  def uses (trait)

    trait.class.instance_methods.each do |nombre|

      unless self.instance_methods.include?(nombre)
        block = trait.method(nombre).to_proc
        define_method(nombre, block)
      end
    end

    nil

  end

end


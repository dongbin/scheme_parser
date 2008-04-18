

class Program < Treetop::Runtime::SyntaxNode
  def eval(env={})
    exprs.inject(nil){ |last_env, exp|
      exp.eval(env)
    }
  end

  def exprs
    [expression] + expressions.exprs
  end

end

class Cons < Treetop::Runtime::SyntaxNode
  def eval(env)
    self
  end

end

class CompoundProcedure < Treetop::Runtime::SyntaxNode

  def initialize(env, args, body)
    @env = env
    @args = args.elements.map{ |arg| arg.name}
    @body = body
  end

  def apply(*values)
    raise SchemeSyntaxError.new("Parameter doesn't match") unless @args.size == values.size
    @body.eval(extend_env(values))
  end

  def extend_env(values)
    @env.merge([@args, values].transpose.
               map{ |key, value| { key => value}}.
               inject{|sum, value| sum.merge(value)})
  end
end


class RubyProcedure < Treetop::Runtime::SyntaxNode

  def initialize(env, args, body)
    @env = env
    @args = args.elements.map{ |arg| arg.name}
    @body = body
  end

  def apply(*values)
    raise SchemeSyntaxError.new("Parameter doesn't match") unless @args.size == values.size
    @body.call(*values)
  end

  def add(x, y)
    x + y
  end


  def extend_env(values)
    @env.merge([@args, values].transpose.map{ |key, value| { key => value}}.
      inject{|sum, value| sum.merge(value)})
  end
end


class SchemeSyntaxError < Exception
end

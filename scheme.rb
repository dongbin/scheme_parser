
module Scheme
  include Treetop::Runtime

  def root
    @root || :program
  end

  module Program0
    def expression
      elements[0]
    end

    def expressions
      elements[1]
    end
  end

  def _nt_program
    start_index = index
    if node_cache[:program].has_key?(index)
      cached = node_cache[:program][index]
      @index = cached.interval.end if cached
      return cached
    end

    i0, s0 = index, []
    r1 = _nt_expression
    s0 << r1
    if r1
      r2 = _nt_expressions
      s0 << r2
    end
    if s0.last
      r0 = (Program).new(input, i0...index, s0)
      r0.extend(Program0)
    else
      self.index = i0
      r0 = nil
    end

    node_cache[:program][start_index] = r0

    return r0
  end

  module Defination0
    def lparen
      elements[0]
    end

    def define
      elements[1]
    end

    def symbol
      elements[2]
    end

    def space
      elements[3]
    end

    def expression
      elements[4]
    end

    def rparen
      elements[5]
    end
  end

  module Defination1
    def eval(env)
      env[symbol.name] = expression.eval(env)
    end
  end

  def _nt_defination
    start_index = index
    if node_cache[:defination].has_key?(index)
      cached = node_cache[:defination][index]
      @index = cached.interval.end if cached
      return cached
    end

    i0, s0 = index, []
    r1 = _nt_lparen
    s0 << r1
    if r1
      r2 = _nt_define
      s0 << r2
      if r2
        r3 = _nt_symbol
        s0 << r3
        if r3
          r4 = _nt_space
          s0 << r4
          if r4
            r5 = _nt_expression
            s0 << r5
            if r5
              r6 = _nt_rparen
              s0 << r6
            end
          end
        end
      end
    end
    if s0.last
      r0 = (SyntaxNode).new(input, i0...index, s0)
      r0.extend(Defination0)
      r0.extend(Defination1)
    else
      self.index = i0
      r0 = nil
    end

    node_cache[:defination][start_index] = r0

    return r0
  end

  module Cons0
    def lparen
      elements[0]
    end

    def car
      elements[2]
    end

    def cdr
      elements[3]
    end

    def rparen
      elements[4]
    end
  end

  def _nt_cons
    start_index = index
    if node_cache[:cons].has_key?(index)
      cached = node_cache[:cons][index]
      @index = cached.interval.end if cached
      return cached
    end

    i0, s0 = index, []
    r1 = _nt_lparen
    s0 << r1
    if r1
      if input.index('cons', index) == index
        r2 = (SyntaxNode).new(input, index...(index + 4))
        @index += 4
      else
        terminal_parse_failure('cons')
        r2 = nil
      end
      s0 << r2
      if r2
        r3 = _nt_expression
        s0 << r3
        if r3
          r4 = _nt_expression
          s0 << r4
          if r4
            r5 = _nt_rparen
            s0 << r5
          end
        end
      end
    end
    if s0.last
      r0 = (Cons).new(input, i0...index, s0)
      r0.extend(Cons0)
    else
      self.index = i0
      r0 = nil
    end

    node_cache[:cons][start_index] = r0

    return r0
  end

  module DefineFunction0
    def lparen
      elements[0]
    end

    def define
      elements[1]
    end

    def lparen
      elements[2]
    end

    def operator
      elements[3]
    end

    def args
      elements[4]
    end

    def rparen
      elements[5]
    end

    def body
      elements[6]
    end

    def rparen
      elements[7]
    end
  end

  module DefineFunction1
    def eval(env)
      env[operator.name] = CompoundProcedure.new(env, args, body)
    end
  end

  def _nt_define_function
    start_index = index
    if node_cache[:define_function].has_key?(index)
      cached = node_cache[:define_function][index]
      @index = cached.interval.end if cached
      return cached
    end

    i0, s0 = index, []
    r1 = _nt_lparen
    s0 << r1
    if r1
      r2 = _nt_define
      s0 << r2
      if r2
        r3 = _nt_lparen
        s0 << r3
        if r3
          r4 = _nt_symbol
          s0 << r4
          if r4
            s5, i5 = [], index
            loop do
              r6 = _nt_symbol
              if r6
                s5 << r6
              else
                break
              end
            end
            if s5.empty?
              self.index = i5
              r5 = nil
            else
              r5 = SyntaxNode.new(input, i5...index, s5)
            end
            s0 << r5
            if r5
              r7 = _nt_rparen
              s0 << r7
              if r7
                r8 = _nt_expression
                s0 << r8
                if r8
                  r9 = _nt_rparen
                  s0 << r9
                end
              end
            end
          end
        end
      end
    end
    if s0.last
      r0 = (SyntaxNode).new(input, i0...index, s0)
      r0.extend(DefineFunction0)
      r0.extend(DefineFunction1)
    else
      self.index = i0
      r0 = nil
    end

    node_cache[:define_function][start_index] = r0

    return r0
  end

  module RubyFunction0
    def lparen
      elements[0]
    end

    def define
      elements[1]
    end

    def lparen
      elements[2]
    end

    def operator
      elements[3]
    end

    def args
      elements[4]
    end

    def rparen
      elements[5]
    end

    def ruby_exp
      elements[6]
    end

    def rparen
      elements[7]
    end
  end

  module RubyFunction1
    def eval(env)
      env[operator.name] = RubyProcedure.new(env, args, ruby_exp)
    end
  end

  def _nt_ruby_function
    start_index = index
    if node_cache[:ruby_function].has_key?(index)
      cached = node_cache[:ruby_function][index]
      @index = cached.interval.end if cached
      return cached
    end

    i0, s0 = index, []
    r1 = _nt_lparen
    s0 << r1
    if r1
      r2 = _nt_define
      s0 << r2
      if r2
        r3 = _nt_lparen
        s0 << r3
        if r3
          r4 = _nt_symbol
          s0 << r4
          if r4
            s5, i5 = [], index
            loop do
              r6 = _nt_symbol
              if r6
                s5 << r6
              else
                break
              end
            end
            if s5.empty?
              self.index = i5
              r5 = nil
            else
              r5 = SyntaxNode.new(input, i5...index, s5)
            end
            s0 << r5
            if r5
              r7 = _nt_rparen
              s0 << r7
              if r7
                r8 = _nt_ruby_exp
                s0 << r8
                if r8
                  r9 = _nt_rparen
                  s0 << r9
                end
              end
            end
          end
        end
      end
    end
    if s0.last
      r0 = (SyntaxNode).new(input, i0...index, s0)
      r0.extend(RubyFunction0)
      r0.extend(RubyFunction1)
    else
      self.index = i0
      r0 = nil
    end

    node_cache[:ruby_function][start_index] = r0

    return r0
  end

  module RubyExp0
    def symbol
      elements[1]
    end
  end

  module RubyExp1
    def call(*args)
      send(symbol.name, *args)
    end
  end

  def _nt_ruby_exp
    start_index = index
    if node_cache[:ruby_exp].has_key?(index)
      cached = node_cache[:ruby_exp][index]
      @index = cached.interval.end if cached
      return cached
    end

    i0, s0 = index, []
    if input.index('@', index) == index
      r1 = (SyntaxNode).new(input, index...(index + 1))
      @index += 1
    else
      terminal_parse_failure('@')
      r1 = nil
    end
    s0 << r1
    if r1
      r2 = _nt_symbol
      s0 << r2
    end
    if s0.last
      r0 = (SyntaxNode).new(input, i0...index, s0)
      r0.extend(RubyExp0)
      r0.extend(RubyExp1)
    else
      self.index = i0
      r0 = nil
    end

    node_cache[:ruby_exp][start_index] = r0

    return r0
  end

  module Function0
    def lparen
      elements[0]
    end

    def operator
      elements[1]
    end

    def operands
      elements[2]
    end

    def rparen
      elements[3]
    end
  end

  module Function1
    def eval(env)
      operator.eval(env).
        apply(*(operands.elements.map{ |value| value.eval }))
    end
  end

  def _nt_function
    start_index = index
    if node_cache[:function].has_key?(index)
      cached = node_cache[:function][index]
      @index = cached.interval.end if cached
      return cached
    end

    i0, s0 = index, []
    r1 = _nt_lparen
    s0 << r1
    if r1
      r2 = _nt_expression
      s0 << r2
      if r2
        r3 = _nt_expressions
        s0 << r3
        if r3
          r4 = _nt_rparen
          s0 << r4
        end
      end
    end
    if s0.last
      r0 = (SyntaxNode).new(input, i0...index, s0)
      r0.extend(Function0)
      r0.extend(Function1)
    else
      self.index = i0
      r0 = nil
    end

    node_cache[:function][start_index] = r0

    return r0
  end

  module Define0
    def space
      elements[0]
    end

    def space
      elements[2]
    end
  end

  def _nt_define
    start_index = index
    if node_cache[:define].has_key?(index)
      cached = node_cache[:define][index]
      @index = cached.interval.end if cached
      return cached
    end

    i0, s0 = index, []
    r1 = _nt_space
    s0 << r1
    if r1
      if input.index('define', index) == index
        r2 = (SyntaxNode).new(input, index...(index + 6))
        @index += 6
      else
        terminal_parse_failure('define')
        r2 = nil
      end
      s0 << r2
      if r2
        r3 = _nt_space
        s0 << r3
      end
    end
    if s0.last
      r0 = (SyntaxNode).new(input, i0...index, s0)
      r0.extend(Define0)
    else
      self.index = i0
      r0 = nil
    end

    node_cache[:define][start_index] = r0

    return r0
  end

  def _nt_primary
    start_index = index
    if node_cache[:primary].has_key?(index)
      cached = node_cache[:primary][index]
      @index = cached.interval.end if cached
      return cached
    end

    i0 = index
    r1 = _nt_plus
    if r1
      r0 = r1
    else
      r2 = _nt_minus
      if r2
        r0 = r2
      else
        r3 = _nt_multiply
        if r3
          r0 = r3
        else
          r4 = _nt_divide
          if r4
            r0 = r4
          else
            self.index = i0
            r0 = nil
          end
        end
      end
    end

    node_cache[:primary][start_index] = r0

    return r0
  end

  module Divide0
    def lparen
      elements[0]
    end

    def dividend
      elements[2]
    end

    def divisor
      elements[3]
    end

    def rparen
      elements[4]
    end
  end

  module Divide1
    def eval(env={})
      dividend.eval(env) / divisor.eval(env)
    end
  end

  def _nt_divide
    start_index = index
    if node_cache[:divide].has_key?(index)
      cached = node_cache[:divide][index]
      @index = cached.interval.end if cached
      return cached
    end

    i0, s0 = index, []
    r1 = _nt_lparen
    s0 << r1
    if r1
      if input.index('/', index) == index
        r2 = (SyntaxNode).new(input, index...(index + 1))
        @index += 1
      else
        terminal_parse_failure('/')
        r2 = nil
      end
      s0 << r2
      if r2
        r3 = _nt_expression
        s0 << r3
        if r3
          r4 = _nt_expression
          s0 << r4
          if r4
            r5 = _nt_rparen
            s0 << r5
          end
        end
      end
    end
    if s0.last
      r0 = (SyntaxNode).new(input, i0...index, s0)
      r0.extend(Divide0)
      r0.extend(Divide1)
    else
      self.index = i0
      r0 = nil
    end

    node_cache[:divide][start_index] = r0

    return r0
  end

  module Multiply0
    def lparen
      elements[0]
    end

    def expressions
      elements[2]
    end

    def rparen
      elements[3]
    end
  end

  module Multiply1
    def eval(env={})
      expressions.exprs_value(env).inject{ |a, b| a * b}
    end
  end

  def _nt_multiply
    start_index = index
    if node_cache[:multiply].has_key?(index)
      cached = node_cache[:multiply][index]
      @index = cached.interval.end if cached
      return cached
    end

    i0, s0 = index, []
    r1 = _nt_lparen
    s0 << r1
    if r1
      if input.index('*', index) == index
        r2 = (SyntaxNode).new(input, index...(index + 1))
        @index += 1
      else
        terminal_parse_failure('*')
        r2 = nil
      end
      s0 << r2
      if r2
        r3 = _nt_expressions
        s0 << r3
        if r3
          r4 = _nt_rparen
          s0 << r4
        end
      end
    end
    if s0.last
      r0 = (SyntaxNode).new(input, i0...index, s0)
      r0.extend(Multiply0)
      r0.extend(Multiply1)
    else
      self.index = i0
      r0 = nil
    end

    node_cache[:multiply][start_index] = r0

    return r0
  end

  module Minus0
    def lparen
      elements[0]
    end

    def minuend
      elements[2]
    end

    def substractor
      elements[3]
    end

    def rparen
      elements[4]
    end
  end

  module Minus1
    def eval(env={})
      minuend.eval(env) - substractor.eval(env)
    end
  end

  def _nt_minus
    start_index = index
    if node_cache[:minus].has_key?(index)
      cached = node_cache[:minus][index]
      @index = cached.interval.end if cached
      return cached
    end

    i0, s0 = index, []
    r1 = _nt_lparen
    s0 << r1
    if r1
      if input.index('-', index) == index
        r2 = (SyntaxNode).new(input, index...(index + 1))
        @index += 1
      else
        terminal_parse_failure('-')
        r2 = nil
      end
      s0 << r2
      if r2
        r3 = _nt_expression
        s0 << r3
        if r3
          r4 = _nt_expression
          s0 << r4
          if r4
            r5 = _nt_rparen
            s0 << r5
          end
        end
      end
    end
    if s0.last
      r0 = (SyntaxNode).new(input, i0...index, s0)
      r0.extend(Minus0)
      r0.extend(Minus1)
    else
      self.index = i0
      r0 = nil
    end

    node_cache[:minus][start_index] = r0

    return r0
  end

  module Plus0
    def lparen
      elements[0]
    end

    def expressions
      elements[2]
    end

    def rparen
      elements[3]
    end
  end

  module Plus1
    def eval(env={})
      expressions.exprs_value(env).inject{ |a, b| a + b}
    end
  end

  def _nt_plus
    start_index = index
    if node_cache[:plus].has_key?(index)
      cached = node_cache[:plus][index]
      @index = cached.interval.end if cached
      return cached
    end

    i0, s0 = index, []
    r1 = _nt_lparen
    s0 << r1
    if r1
      if input.index('+', index) == index
        r2 = (SyntaxNode).new(input, index...(index + 1))
        @index += 1
      else
        terminal_parse_failure('+')
        r2 = nil
      end
      s0 << r2
      if r2
        r3 = _nt_expressions
        s0 << r3
        if r3
          r4 = _nt_rparen
          s0 << r4
        end
      end
    end
    if s0.last
      r0 = (SyntaxNode).new(input, i0...index, s0)
      r0.extend(Plus0)
      r0.extend(Plus1)
    else
      self.index = i0
      r0 = nil
    end

    node_cache[:plus][start_index] = r0

    return r0
  end

  def _nt_atom
    start_index = index
    if node_cache[:atom].has_key?(index)
      cached = node_cache[:atom][index]
      @index = cached.interval.end if cached
      return cached
    end

    i0 = index
    r1 = _nt_string
    if r1
      r0 = r1
    else
      r2 = _nt_number
      if r2
        r0 = r2
      else
        r3 = _nt_symbol
        if r3
          r0 = r3
        else
          self.index = i0
          r0 = nil
        end
      end
    end

    node_cache[:atom][start_index] = r0

    return r0
  end

  module Expression0
    def space
      elements[0]
    end

    def e
      elements[1]
    end

    def space
      elements[2]
    end
  end

  module Expression1
    def eval(env = {})
      e.eval(env)
    end
  end

  def _nt_expression
    start_index = index
    if node_cache[:expression].has_key?(index)
      cached = node_cache[:expression][index]
      @index = cached.interval.end if cached
      return cached
    end

    i0, s0 = index, []
    r1 = _nt_space
    s0 << r1
    if r1
      i2 = index
      r3 = _nt_atom
      if r3
        r2 = r3
      else
        r4 = _nt_primary
        if r4
          r2 = r4
        else
          r5 = _nt_defination
          if r5
            r2 = r5
          else
            r6 = _nt_cons
            if r6
              r2 = r6
            else
              r7 = _nt_define_function
              if r7
                r2 = r7
              else
                r8 = _nt_ruby_function
                if r8
                  r2 = r8
                else
                  r9 = _nt_function
                  if r9
                    r2 = r9
                  else
                    self.index = i2
                    r2 = nil
                  end
                end
              end
            end
          end
        end
      end
      s0 << r2
      if r2
        r10 = _nt_space
        s0 << r10
      end
    end
    if s0.last
      r0 = (SyntaxNode).new(input, i0...index, s0)
      r0.extend(Expression0)
      r0.extend(Expression1)
    else
      self.index = i0
      r0 = nil
    end

    node_cache[:expression][start_index] = r0

    return r0
  end

  module Expressions0
    def exprs_value(env)
      exprs.map{|e| e.eval(env)}
    end

    def exprs
      elements
    end
  end

  def _nt_expressions
    start_index = index
    if node_cache[:expressions].has_key?(index)
      cached = node_cache[:expressions][index]
      @index = cached.interval.end if cached
      return cached
    end

    s0, i0 = [], index
    loop do
      r1 = _nt_expression
      if r1
        s0 << r1
      else
        break
      end
    end
    r0 = SyntaxNode.new(input, i0...index, s0)
    r0.extend(Expressions0)

    node_cache[:expressions][start_index] = r0

    return r0
  end

  module String0
  end

  module String1
  end

  module String2
    def eval(env={})
      text_value[1..-2]
    end
  end

  def _nt_string
    start_index = index
    if node_cache[:string].has_key?(index)
      cached = node_cache[:string][index]
      @index = cached.interval.end if cached
      return cached
    end

    i0, s0 = index, []
    if input.index('"', index) == index
      r1 = (SyntaxNode).new(input, index...(index + 1))
      @index += 1
    else
      terminal_parse_failure('"')
      r1 = nil
    end
    s0 << r1
    if r1
      s2, i2 = [], index
      loop do
        i3 = index
        i4, s4 = index, []
        i5 = index
        if input.index('"', index) == index
          r6 = (SyntaxNode).new(input, index...(index + 1))
          @index += 1
        else
          terminal_parse_failure('"')
          r6 = nil
        end
        if r6
          r5 = nil
        else
          self.index = i5
          r5 = SyntaxNode.new(input, index...index)
        end
        s4 << r5
        if r5
          if index < input_length
            r7 = (SyntaxNode).new(input, index...(index + 1))
            @index += 1
          else
            terminal_parse_failure("any character")
            r7 = nil
          end
          s4 << r7
        end
        if s4.last
          r4 = (SyntaxNode).new(input, i4...index, s4)
          r4.extend(String0)
        else
          self.index = i4
          r4 = nil
        end
        if r4
          r3 = r4
        else
          if input.index('\"', index) == index
            r8 = (SyntaxNode).new(input, index...(index + 2))
            @index += 2
          else
            terminal_parse_failure('\"')
            r8 = nil
          end
          if r8
            r3 = r8
          else
            self.index = i3
            r3 = nil
          end
        end
        if r3
          s2 << r3
        else
          break
        end
      end
      r2 = SyntaxNode.new(input, i2...index, s2)
      s0 << r2
      if r2
        if input.index('"', index) == index
          r9 = (SyntaxNode).new(input, index...(index + 1))
          @index += 1
        else
          terminal_parse_failure('"')
          r9 = nil
        end
        s0 << r9
      end
    end
    if s0.last
      r0 = (SyntaxNode).new(input, i0...index, s0)
      r0.extend(String1)
      r0.extend(String2)
    else
      self.index = i0
      r0 = nil
    end

    node_cache[:string][start_index] = r0

    return r0
  end

  module Number0
  end

  module Number1
    def eval(env={})
      text_value.to_f
    end
  end

  def _nt_number
    start_index = index
    if node_cache[:number].has_key?(index)
      cached = node_cache[:number][index]
      @index = cached.interval.end if cached
      return cached
    end

    i0, s0 = index, []
    if input.index(/[1-9]/, index) == index
      r1 = (SyntaxNode).new(input, index...(index + 1))
      @index += 1
    else
      r1 = nil
    end
    s0 << r1
    if r1
      s2, i2 = [], index
      loop do
        if input.index(/[0-9]/, index) == index
          r3 = (SyntaxNode).new(input, index...(index + 1))
          @index += 1
        else
          r3 = nil
        end
        if r3
          s2 << r3
        else
          break
        end
      end
      r2 = SyntaxNode.new(input, i2...index, s2)
      s0 << r2
    end
    if s0.last
      r0 = (SyntaxNode).new(input, i0...index, s0)
      r0.extend(Number0)
      r0.extend(Number1)
    else
      self.index = i0
      r0 = nil
    end

    node_cache[:number][start_index] = r0

    return r0
  end

  module Lparen0
    def space
      elements[0]
    end

    def space
      elements[2]
    end
  end

  def _nt_lparen
    start_index = index
    if node_cache[:lparen].has_key?(index)
      cached = node_cache[:lparen][index]
      @index = cached.interval.end if cached
      return cached
    end

    i0, s0 = index, []
    r1 = _nt_space
    s0 << r1
    if r1
      if input.index('(', index) == index
        r2 = (SyntaxNode).new(input, index...(index + 1))
        @index += 1
      else
        terminal_parse_failure('(')
        r2 = nil
      end
      s0 << r2
      if r2
        r3 = _nt_space
        s0 << r3
      end
    end
    if s0.last
      r0 = (SyntaxNode).new(input, i0...index, s0)
      r0.extend(Lparen0)
    else
      self.index = i0
      r0 = nil
    end

    node_cache[:lparen][start_index] = r0

    return r0
  end

  module Rparen0
    def space
      elements[0]
    end

    def space
      elements[2]
    end
  end

  def _nt_rparen
    start_index = index
    if node_cache[:rparen].has_key?(index)
      cached = node_cache[:rparen][index]
      @index = cached.interval.end if cached
      return cached
    end

    i0, s0 = index, []
    r1 = _nt_space
    s0 << r1
    if r1
      if input.index(')', index) == index
        r2 = (SyntaxNode).new(input, index...(index + 1))
        @index += 1
      else
        terminal_parse_failure(')')
        r2 = nil
      end
      s0 << r2
      if r2
        r3 = _nt_space
        s0 << r3
      end
    end
    if s0.last
      r0 = (SyntaxNode).new(input, i0...index, s0)
      r0.extend(Rparen0)
    else
      self.index = i0
      r0 = nil
    end

    node_cache[:rparen][start_index] = r0

    return r0
  end

  module Symbol0
    def space
      elements[0]
    end

  end

  module Symbol1
    def eval(env)
      env[name]
    end

    def name
      text_value.strip
    end
  end

  def _nt_symbol
    start_index = index
    if node_cache[:symbol].has_key?(index)
      cached = node_cache[:symbol][index]
      @index = cached.interval.end if cached
      return cached
    end

    i0, s0 = index, []
    r1 = _nt_space
    s0 << r1
    if r1
      if input.index(/[a-z]/, index) == index
        r2 = (SyntaxNode).new(input, index...(index + 1))
        @index += 1
      else
        r2 = nil
      end
      s0 << r2
      if r2
        s3, i3 = [], index
        loop do
          i4 = index
          if input.index(/[a-z]/, index) == index
            r5 = (SyntaxNode).new(input, index...(index + 1))
            @index += 1
          else
            r5 = nil
          end
          if r5
            r4 = r5
          else
            if input.index(/[0-9]/, index) == index
              r6 = (SyntaxNode).new(input, index...(index + 1))
              @index += 1
            else
              r6 = nil
            end
            if r6
              r4 = r6
            else
              if input.index(/[_]/, index) == index
                r7 = (SyntaxNode).new(input, index...(index + 1))
                @index += 1
              else
                r7 = nil
              end
              if r7
                r4 = r7
              else
                self.index = i4
                r4 = nil
              end
            end
          end
          if r4
            s3 << r4
          else
            break
          end
        end
        r3 = SyntaxNode.new(input, i3...index, s3)
        s0 << r3
      end
    end
    if s0.last
      r0 = (SyntaxNode).new(input, i0...index, s0)
      r0.extend(Symbol0)
      r0.extend(Symbol1)
    else
      self.index = i0
      r0 = nil
    end

    node_cache[:symbol][start_index] = r0

    return r0
  end

  module Keyword0
  end

  def _nt_keyword
    start_index = index
    if node_cache[:keyword].has_key?(index)
      cached = node_cache[:keyword][index]
      @index = cached.interval.end if cached
      return cached
    end

    i0, s0 = index, []
    i1 = index
    if input.index('if', index) == index
      r2 = (SyntaxNode).new(input, index...(index + 2))
      @index += 2
    else
      terminal_parse_failure('if')
      r2 = nil
    end
    if r2
      r1 = r2
    else
      if input.index('else', index) == index
        r3 = (SyntaxNode).new(input, index...(index + 4))
        @index += 4
      else
        terminal_parse_failure('else')
        r3 = nil
      end
      if r3
        r1 = r3
      else
        if input.index('define', index) == index
          r4 = (SyntaxNode).new(input, index...(index + 6))
          @index += 6
        else
          terminal_parse_failure('define')
          r4 = nil
        end
        if r4
          r1 = r4
        else
          self.index = i1
          r1 = nil
        end
      end
    end
    s0 << r1
    if r1
      i5 = index
      r6 = _nt_non_space_char
      if r6
        r5 = nil
      else
        self.index = i5
        r5 = SyntaxNode.new(input, index...index)
      end
      s0 << r5
    end
    if s0.last
      r0 = (SyntaxNode).new(input, i0...index, s0)
      r0.extend(Keyword0)
    else
      self.index = i0
      r0 = nil
    end

    node_cache[:keyword][start_index] = r0

    return r0
  end

  module NonSpaceChar0
  end

  def _nt_non_space_char
    start_index = index
    if node_cache[:non_space_char].has_key?(index)
      cached = node_cache[:non_space_char][index]
      @index = cached.interval.end if cached
      return cached
    end

    i0, s0 = index, []
    i1 = index
    if input.index(/[ \n]/, index) == index
      r2 = (SyntaxNode).new(input, index...(index + 1))
      @index += 1
    else
      r2 = nil
    end
    if r2
      r1 = nil
    else
      self.index = i1
      r1 = SyntaxNode.new(input, index...index)
    end
    s0 << r1
    if r1
      if index < input_length
        r3 = (SyntaxNode).new(input, index...(index + 1))
        @index += 1
      else
        terminal_parse_failure("any character")
        r3 = nil
      end
      s0 << r3
    end
    if s0.last
      r0 = (SyntaxNode).new(input, i0...index, s0)
      r0.extend(NonSpaceChar0)
    else
      self.index = i0
      r0 = nil
    end

    node_cache[:non_space_char][start_index] = r0

    return r0
  end

  def _nt_space
    start_index = index
    if node_cache[:space].has_key?(index)
      cached = node_cache[:space][index]
      @index = cached.interval.end if cached
      return cached
    end

    s0, i0 = [], index
    loop do
      if input.index(/[ \n]/, index) == index
        r1 = (SyntaxNode).new(input, index...(index + 1))
        @index += 1
      else
        r1 = nil
      end
      if r1
        s0 << r1
      else
        break
      end
    end
    r0 = SyntaxNode.new(input, i0...index, s0)

    node_cache[:space][start_index] = r0

    return r0
  end

end

class SchemeParser < Treetop::Runtime::CompiledParser
  include Scheme
end


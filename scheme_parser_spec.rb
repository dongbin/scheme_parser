require "rubygems"
require "spec"
require "treetop"
require "nodes"
require "scheme"

describe SchemeParser, "atom" do
  before do
    @parser = SchemeParser.new
  end

  it do
    @parser.parse("1").eval.should == 1
  end

  it do
    @parser.parse('"Hello World"').eval.should == "Hello World"
  end

end


describe SchemeParser , "for primitive operator"do

  before do
    @parser = SchemeParser.new
  end

  it 'can multiply' do
    result = @parser.parse("(* 2 3)")
    result.eval.should == 6
  end

  it 'can divide' do
    result = @parser.parse("( / 6 3 )")
    result.eval.should == 2
  end

  it 'can parse plus' do
    result = @parser.parse("(+ 1 2)")
    result.eval.should == 3

    result = @parser.parse('(+ "1" "2")')
    result.eval.should == "12"
  end

  it 'can parse minus' do
    result = @parser.parse("(- 3 1)")
    result.eval.should == 2
  end

  it 'can parse nested primitive expressions' do
    result = @parser.parse("(+ 1 (+ 1 3))")
    result.eval.should == 5
  end

end

describe SchemeParser do

  before do
    @parser = SchemeParser.new
  end

  it "can define var" do
    result = @parser.parse("(define a 1) (+ 1 a)")
    result.eval.should == 2
  end

  it do
    result = @parser.parse("(define a (+ 1 2)) (+ 1 a)")
    result.eval.should == 4
  end

  it "can make cons " do
    result = @parser.parse("(cons 1 2)")
    result.eval.should be_instance_of(Cons)
  end


  describe "compound function" do

    before do
      @define = "(define (add x y) (+ x y))"
      @procedure = @parser.parse(@define).eval
    end

    it "can be defined " do
      @procedure.apply(1, 2).should == 3
    end

    it "can call function" do
      result = @parser.parse(@define +
                              " (add 1 2) ")
      result.eval.should == 3
    end

    it "should raise error when parameters mismatch" do
      lambda{ @procedure.apply(1, 2, 3)}.should raise_error(SchemeSyntaxError)
    end

  end

end

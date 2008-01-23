require File.dirname(__FILE__) + "/helper"

class ECMAVisitorTest < Test::Unit::TestCase
  def setup
    @parser = RKelly::Parser.new
  end

  def test_this_node
    assert_to_ecma('this.foo;')
  end

  def test_bitwise_not_node
    assert_to_ecma('~10;')
  end

  def test_delete_node
    assert_to_ecma('delete foo;')
  end

  def test_element_node
    assert_to_ecma('var foo = [1];')
  end

  def test_logical_not_node
    assert_to_ecma('!foo;')
  end

  def test_unary_minus_node
    assert_to_ecma('-0;')
  end

  def test_return_node
    assert_to_ecma('return foo;')
    assert_to_ecma('return;')
  end

  def test_throw_node
    assert_to_ecma('throw foo;')
  end

  def test_type_of_node
    assert_to_ecma('typeof foo;')
  end

  def test_unary_plus_node
    assert_to_ecma('+10;')
  end

  def test_void_node
    assert_to_ecma('void(0);')
  end

  [
    [:add, '+'],
    [:and_equal, '&='],
    [:bit_and, '&'],
    [:bit_or, '|'],
    [:bit_xor, '^'],
    [:divide, '/'],
    [:divide_equal, '/='],
    [:equal_equal, '=='],
    [:greater, '>'],
    [:greater_or_equal, '>='],
    [:left_shift, '<<'],
    [:left_shift_equal, '<<='],
    [:less_or_equal, '<='],
    [:logical_and, '&&'],
    [:logical_or, '||'],
    [:minus_equal, '-='],
    [:mod, '%'],
    [:mod_equal, '%='],
    [:multiply, '*'],
    [:multiply_equal, '*='],
    [:not_equal, '!='],
    [:not_strict_equal, '!=='],
    [:or_equal, '|='],
    [:plus_equal, '+='],
    [:right_shift, '>>'],
    [:right_shift_equal, '>>='],
    [:strict_equal, '==='],
    [:subtract, '-'],
    [:ur_shift, '>>>'],
    [:uright_shift_equal, '>>>='],
    [:xor_equal, '^='],
    [:instanceof, 'instanceof'],
  ].each do |name, value|
    define_method(:"test_#{name}_node") do
      assert_to_ecma("10 #{value} 20;")
    end
  end

  def test_while_node
    assert_to_ecma("while(true) { foo(); }")
  end

  def test_switch_node
    assert_to_ecma("switch(a) { }")
  end

  def test_switch_case_node
    assert_to_ecma("switch(a) {
                   case 1:
                    foo();
                   break;
    }")
  end

  def test_do_while_node
    assert_to_ecma("do { foo(); } while(true);")
  end

  def test_with_node
    assert_to_ecma("with(o) { foo(); }")
  end

  def test_const_statement_node
    assert_to_ecma("const foo;")
  end

  def test_label_node
    assert_to_ecma("foo: var foo;")
  end

  def test_object_literal
    assert_to_ecma("var foo = { };")
  end

  def test_property
    assert_to_ecma("var foo = { bar: 10 };")
  end

  def assert_to_ecma(expected, actual = nil)
    ecma = @parser.parse(actual || expected).to_ecma
    ecma = ecma.gsub(/\n/, ' ').gsub(/\s+/, ' ')
    expected = expected.gsub(/\n/, ' ').gsub(/\s+/, ' ')
    assert_equal(expected, ecma)
  end
end
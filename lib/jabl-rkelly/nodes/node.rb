module Jabl::RKelly
  module Nodes
    class Node
      include Jabl::RKelly::Visitable
      include Jabl::RKelly::Visitors
      include Enumerable

      attr_accessor :value
      def initialize(value)
        @value = value
      end

      def ==(other)
        other.is_a?(self.class) && @value == other.value
      end
      alias :=~ :==

      def pointcut(pattern)
        ast = Jabl::RKelly::Parser.new.parse(pattern)
        # Only take the first statement
        finder = ast.value.first.class.to_s =~ /StatementNode$/ ?
          ast.value.first.value : ast.value.first
        visitor = PointcutVisitor.new(finder)
        visitor.accept(self)
        visitor
      end

      def to_sexp
        SexpVisitor.new.accept(self)
      end

      def to_ecma(context)
        ECMAVisitor.new(context).accept(self)
      end

      def to_dots
        visitor = DotVisitor.new
        visitor.accept(self)
        header = <<-END
digraph g {
graph [ rankdir = "TB" ];
node [
  fontsize = "16"
  shape = "ellipse"
];
edge [ ];
        END
        nodes = visitor.nodes.map { |x| x.to_s }.join("\n")
        counter = 0
        arrows = visitor.arrows.map { |x|
          s = "#{x} [\nid = #{counter}\n];"
          counter += 1
          s
        }.join("\n")
        "#{header}\n#{nodes}\n#{arrows}\n}"
      end

      def each(&block)
        EnumerableVisitor.new(block).accept(self)
      end

      def context_refs
        select {|n| n.is_a?(AttrNode) || n.is_a?(ContextDotNode)}.size
      end
    end

    %w[EmptyStatement ExpressionStatement True Delete Return TypeOf
       SourceElements Number LogicalNot AssignExpr FunctionBody Attr
       ObjectLiteral UnaryMinus Throw This BitwiseNot Element String
       Array CaseBlock Null Break Parameter Block False Void Regexp
       Arguments Attr ContextDot Continue ConstStatement UnaryPlus
       VarStatement].each do |node|
      eval "class #{node}Node < Node; end"
    end
  end
end

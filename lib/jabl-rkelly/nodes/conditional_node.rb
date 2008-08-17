require 'jabl-rkelly/nodes/if_node'

module Jabl::RKelly
  module Nodes
    class ConditionalNode < IfNode
      def initialize(test, true_block, else_block)
        super
      end
    end
  end
end

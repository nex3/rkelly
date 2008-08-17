require 'jabl-rkelly/nodes/node'
require 'jabl-rkelly/nodes/function_expr_node'
Dir[File.join(File.dirname(__FILE__), "nodes/*_node.rb")].each do |file|
  require file[/jabl-rkelly\/nodes\/.*/]
end

require 'jabl-rkelly/nodes/node'
Dir[File.join(File.dirname(__FILE__), "nodes/*_node.rb")].each do |file|
  require file[/jabl-rkelly\/nodes\/.*/]
end

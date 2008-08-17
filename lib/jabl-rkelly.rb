dir = File.dirname(__FILE__)
$LOAD_PATH << dir unless $LOAD_PATH.include?(dir)

module Jabl; end

require 'jabl-rkelly/visitable'
require 'jabl-rkelly/visitors'
require 'jabl-rkelly/parser'
require 'jabl-rkelly/runtime'

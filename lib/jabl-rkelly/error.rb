module Jabl::RKelly
  class ParserError < StandardError
    attr_accessor :token_id
    attr_accessor :token_value
    attr_accessor :token_name

    def initialize(token_id, token_value, token_name)
      @token_id = token_id
      @token_value = token_value
      @token_name = token_name
      super "Unexpected token #{token_name}"
    end
  end
end

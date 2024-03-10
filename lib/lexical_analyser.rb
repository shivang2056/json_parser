class LexicalAnalyser
  class << self
    STRUCTURAL_TOKEN_TYPES = {
      '{' => 'l_brace',
      '}' => 'r_brace',
      ':' => 'colon',
      ',' => 'comma',
      '[' => 'l_bracket',
      ']' => 'r_bracket'
    }

    def compute_tokens(json_str)
      tokens = []

      until json_str.empty?
        tokens << case json_str.strip
                  when structural_token_match
                    then { type: STRUCTURAL_TOKEN_TYPES[$&], value: $& }
                  when integer_match
                    then { type: 'Integer', value: $1.to_i }
                  when string_match
                    then { type: 'String', value: $1 }
                  when boolean_match
                    then { type: 'Boolean', value: $1 == 'true' }
                  when null_match
                    then { type: 'Null', value: nil }
                  else
                    raise RuntimeError, "Unable to parse at #{json_str}", []
                  end

        json_str = $'
      end

      tokens
    end

    private

    def structural_token_match
      /\A[\{\}:,\[\]]/
    end

    def integer_match
      /\A(\d+)/
    end

    def string_match
      /\A"([^"]*?)"/
    end

    def boolean_match
      /\A(true|false)/
    end

    def null_match
      /\Anull/
    end
  end
end


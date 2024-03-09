class LexicalAnalyser
  class << self
    TOKEN_TYPES = {
      '{' => 'l_brace',
      '}' => 'r_brace',
      ':' => 'colon',
      ',' => 'comma',
    }

    def compute_tokens(json_str)
      tokens = []

      until json_str.empty?
        tokens << case json_str.strip
                  when /\A[\{\}:,]/
                    then { type: TOKEN_TYPES[$&], value: $& }
                  when /\A(\d+)/
                    then { type: 'Integer', value: $1.to_i }
                  when /\A"([^"]*?)"/
                    then { type: 'String', value: $1 }
                  when /\A(true|false)/
                    then { type: 'Boolean', value: $1 == 'true' }
                  when /\Anull/
                    then { type: 'Null', value: nil }
                  else
                    puts json_str
                    raise
                  end

        json_str = $'
      end

      return tokens
    end
  end
end


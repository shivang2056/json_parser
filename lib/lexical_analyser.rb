class LexicalAnalyser
  class << self
    TOKEN_TYPES = {
      '{' => :l_brace,
      '}' => :r_brace,
      ':' => :colon
    }

    def compute_tokens(json_str)
      tokens = []

      until json_str.empty?
        tokens << case json_str.strip
                  when /\A[\{\}:]/
                    then { type: TOKEN_TYPES[$&], value: $&}
                  when /\A"([^"]*?)"/
                    then { type: 'String', value: $1 }
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


class LexicalAnalyser
  class << self
    TOKEN_TYPES = {
      '{' => :l_brace,
      '}' => :r_brace
    }

    def compute_tokens(json_str)
      tokens = []

      until json_str.empty?
        tokens << case json_str
                  when /\A[\{\}]/
                    then { type: TOKEN_TYPES[$&], value: $&}
                  else
                    raise
                  end

        json_str = $'
      end

      return tokens
    end
  end
end


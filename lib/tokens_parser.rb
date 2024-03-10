class TokensParser
  class << self
    def parse_value(tokens)
      token = tokens.shift

      case token[:type].to_s
      when 'String', 'Integer', 'Boolean', 'Null'
        token[:value]
      when 'l_brace'
        parse_object(tokens)
      when 'l_bracket'
        parse_array(tokens)
      else
        raise "Unexpected token #{token}"
      end
    end

    def parse_object(tokens)
      hash = {}

      until tokens.first[:type] == 'r_brace'
        key = parse_value(tokens)
        raise_unless_token_is_colon(tokens.shift)

        hash[key] = parse_value(tokens)
        raise_unless_token_is_comma_or_r_brace(tokens.first)

        tokens = further_check_if_next_token_is_comma(tokens)
      end

      tokens.shift
      hash
    end

    def parse_array(tokens)
      arr = []

      until tokens.first[:type] == 'r_bracket'
        arr << parse_value(tokens)
        raise_unless_token_is_comma_or_r_bracket(tokens.first)

        tokens = further_check_if_next_token_is_comma(tokens)
      end

      tokens.shift
      arr
    end

    private

    def raise_unless_token_is_colon(token)
      unless token[:type] == 'colon'
        raise RuntimeError, "Expected colon", []
      end
    end

    def raise_unless_token_is_comma_or_r_brace(token)
      unless ['comma', 'r_brace'].include?(token[:type])
        raise RuntimeError, "Expected comma or closing brace", []
      end
    end

    def further_check_if_next_token_is_comma(tokens)
      if tokens.first[:type] == 'comma'
        tokens.shift

        raise_unless_token_is_string(tokens.first)
      end

      tokens
    end

    def raise_unless_token_is_string(token)
      unless token[:type] == 'String'
        raise RuntimeError, "Expected next string key", []
      end
    end

    def raise_unless_token_is_comma_or_r_bracket(token)
      unless ['comma', 'r_bracket'].include?(token[:type])
        raise RuntimeError, "Expected comma or closing bracket", []
      end
    end
  end
end

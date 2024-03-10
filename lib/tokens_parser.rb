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
        raise "\njson_parser: Unexpected token #{token}"
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
      raise "\njson_parser: Expected colon" unless token[:type] == 'colon'
    end

    def raise_unless_token_is_comma_or_r_brace(token)
      raise "\njson_parser: Expected comma or closing brace" unless ['comma', 'r_brace'].include?(token[:type])
    end

    def further_check_if_next_token_is_comma(tokens)
      if tokens.first[:type] == 'comma'
        tokens.shift

        raise_unless_token_is_string(tokens.first)
      end

      tokens
    end

    def raise_unless_token_is_string(token)
      raise "\njson_parser: Expected next string key" unless token[:type] == 'String'
    end

    def raise_unless_token_is_comma_or_r_bracket(token)
      raise "\njson_parser: Expected comma or closing bracket" unless ['comma', 'r_bracket'].include?(token[:type])
    end
  end
end

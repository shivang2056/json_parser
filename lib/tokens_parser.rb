class TokensParser
  class << self
    def parse(tokens)
      token = tokens.shift

      case token[:type]
      when 'l_brace'
        parse_object(tokens)
      else
        raise "\njson_parser: Unexpected token #{token}"
      end
    end

    def parse_object(tokens)
      hash = {}

      until tokens.first[:type] == 'r_brace'
        key = parse_value(tokens)
        colon_token = tokens.shift
        raise "\njson_parser: Expected colon" unless colon_token[:type] == 'colon'
        value = parse_value(tokens)

        hash[key] = value

        next_token_type = tokens.first ? tokens.first[:type] : nil

        raise "\njson_parser: Expected comma or closing brace" unless ['comma', 'r_brace'].include?(next_token_type)

        if tokens.first[:type] == 'comma'
          tokens.shift

          next_token_type = tokens.first ? tokens.first[:type] : nil

          raise "\njson_parser: Expected next string key" unless next_token_type == 'String'
        end
      end

      tokens.shift
      return hash
    end

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

    def parse_array(tokens)
      arr = []

      until tokens.first[:type] == 'r_bracket'
        arr << parse_value(tokens)

        next_token_type = tokens.first ? tokens.first[:type] : nil

        raise "\njson_parser: Expected comma or closing bracket" unless ['comma', 'r_bracket'].include?(next_token_type)

        if tokens.first[:type] == 'comma'
          tokens.shift

          next_token_type = tokens.first ? tokens.first[:type] : nil

          raise "\njson_parser: Expected next string key" unless next_token_type == 'String'
        end
      end

      tokens.shift
      return arr
    end
  end
end

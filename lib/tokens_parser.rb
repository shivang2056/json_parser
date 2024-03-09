class TokensParser
  class << self
    def parse(tokens)
      token = tokens.shift

      case token[:type]
      when 'l_brace'
        parse_object(tokens)
      else
        puts token
        raise
      end
    end

    def parse_object(tokens)
      hash = {}

      until tokens.first[:type] == 'r_brace'
        key = parse_value(tokens)
        tokens.shift
        value = parse_value(tokens)

        hash[key] = value

        tokens.shift if tokens.first[:type] == 'comma'
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
        puts token
        puts tokens
        raise
      end
    end

    def parse_array(tokens)
      arr = []

      until tokens.first[:type] == 'r_bracket'
        arr << parse_value(tokens)
        tokens.shift if tokens.first[:type] == 'comma'
      end

      tokens.shift
      return arr
    end
  end
end

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

      until tokens.empty? || tokens.first[:type] == :r_brace
        key = parse_value(tokens)
        tokens.shift
        value = parse_value(tokens)

        hash[key] = value
        tokens.shift
      end

      return hash if tokens.empty? || tokens.first[:type] = :r_brace
    end

    def parse_value(tokens)
      token = tokens.shift

      case token[:type].to_s
      when 'String', 'Integer', 'Boolean', 'Null'
        token[:value]
      else
        puts token
        raise
      end
    end
  end
end

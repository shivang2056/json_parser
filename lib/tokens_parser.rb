class TokensParser
  class << self
    def parse(tokens)
      token = tokens.shift

      case token[:type]
      when :l_brace
        parse_object(tokens)
      else
        raise
      end
    end

    def parse_object(tokens)
      hash = {}

      until tokens.first[:type] == :r_brace
        key = parse_value(tokens)
        tokens.shift
        value = parse_value(tokens)

        hash[key] = value
      end

      return hash if tokens.first[:type] = :r_brace
    end

    def parse_value(tokens)
      token = tokens.shift

      case token[:type]
      when 'String'
        token[:value]
      else
        puts token
        raise
      end
    end
  end
end

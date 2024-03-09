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

      return hash if tokens.first[:type] == :r_brace
    end
  end
end

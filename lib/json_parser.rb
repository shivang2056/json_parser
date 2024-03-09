require_relative './lexical_analyser'
require_relative './tokens_parser'

class JsonParser
  def initialize(json_str = nil)
    @json_str = File.read("tests/step1/valid.json")
  end

  def parse
    tokens = LexicalAnalyser.compute_tokens(@json_str)
    puts "Computed Tokens: #{tokens}"
    parsed_json = TokensParser.parse(tokens)
    puts "Parsed JSON: #{parsed_json}"
  end
end

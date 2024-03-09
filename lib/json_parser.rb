require_relative './lexical_analyser'
require_relative './tokens_parser'
require 'json'

class JsonParser
  def initialize(json_str = nil)
    @json_str = File.read("tests/step2/valid.json")
  end

  def parse
    tokens = LexicalAnalyser.compute_tokens(@json_str)
    puts "Computed Tokens: #{JSON.pretty_generate(tokens)}"
    parsed_json = TokensParser.parse(tokens)
    puts "Parsed JSON: #{parsed_json}"
  end
end

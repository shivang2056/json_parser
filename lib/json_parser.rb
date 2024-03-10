require_relative './lexical_analyser'
require_relative './tokens_parser'
require 'json'

class JsonParser
  def initialize(file_path)
    @json_str = read_file(file_path)
  end

  def parse(print_tokens = false)
    raise "\njson_parser: File is empty" if @json_str.empty?

    tokens = LexicalAnalyser.compute_tokens(@json_str)
    puts "Computed Tokens: #{JSON.pretty_generate(tokens)}" if print_tokens

    TokensParser.parse_value(tokens)
  end

  private

  def read_file(path)
    if path.nil?
      raise "\njson_parser: File path not provided"
    elsif File.exist?(path)
      File.read(path)
    else
      raise "\njson_parser: #{path}: open: No such file or directory"
    end
  end
end

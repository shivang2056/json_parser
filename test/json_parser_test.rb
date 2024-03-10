require "minitest/autorun"
require_relative "../lib/json_parser"
require "byebug"

class JsonParserTest < Minitest::Test

  def test_for_step1_valid_json
    assert_equal({}, JsonParser.new("./test/json_files/step1/valid.json").parse)
  end

  def test_for_step1_invalid_json
    error = assert_raises(RuntimeError) do
      JsonParser.new("./test/json_files/step1/invalid.json").parse
    end

    assert_equal "\njson_parser: File is empty", error.message
  end

  def test_for_step2_valid_json
    assert_equal({"key" => "value"}, JsonParser.new("./test/json_files/step2/valid.json").parse)
  end

  def test_for_step2_valid_json2
    assert_equal({"key" => "value", "key2" => "value"}, JsonParser.new("./test/json_files/step2/valid2.json").parse)
  end

  def test_for_step2_invalid_json
    error = assert_raises(RuntimeError) do
      JsonParser.new("./test/json_files/step2/invalid.json").parse
    end

    assert_equal "\njson_parser: Expected next string key", error.message
  end

  def test_for_step2_invalid_json2
    error = assert_raises(RuntimeError) do
      JsonParser.new("./test/json_files/step2/invalid2.json").parse
    end

    assert_equal "\njson_parser: Unable to parse at \n  key2: \"value\"\n}", error.message
  end

  def test_for_step3_valid_json
    assert_equal({"key1"=>true, "key2"=>false, "key3"=>nil, "key4"=>"value", "key5"=>101},
      JsonParser.new("./test/json_files/step3/valid.json").parse)
  end

  def test_for_step3_invalid_json
    error = assert_raises(RuntimeError) do
      JsonParser.new("./test/json_files/step3/invalid.json").parse
    end

    assert_equal "\njson_parser: Unable to parse at  False,\n  \"key3\": null,\n  \"key4\": \"value\",\n  \"key5\": 101\n}", error.message
  end

  def test_for_step4_valid_json
    assert_equal({"key"=>"value", "key-n"=>101, "key-o"=>{}, "key-l"=>[]},
      JsonParser.new("./test/json_files/step4/valid.json").parse)
  end

  def test_for_step4_valid_json2
    assert_equal({"key"=>"value", "key-n"=>101,
      "key-o"=>{"inner key"=>"inner value"}, "key-l"=>["list value1", "list value2"]},
      JsonParser.new("./test/json_files/step4/valid2.json").parse)
  end

  def test_for_step4_invalid_json
    error = assert_raises(RuntimeError) do
      JsonParser.new("./test/json_files/step4/invalid.json").parse
    end

    assert_equal "\njson_parser: Unable to parse at 'list value']\n}", error.message
  end

  def test_for_blank_file_path
    error = assert_raises(RuntimeError) do
      JsonParser.new(nil).parse
    end

    assert_equal "\njson_parser: File path not provided", error.message
  end

  def test_for_incorrect_file_path
    error = assert_raises(RuntimeError) do
      JsonParser.new("incorrect_file_path").parse
    end

    assert_equal "\njson_parser: incorrect_file_path: open: No such file or directory", error.message
  end
end
# json_parser

The json_parser is a Ruby-based command-line tool designed to interpret strings formatted in JSON. It handles strings, numbers, booleans, arrays, and nested objects, converting them into the equivalent Ruby data structures when they conform to the JSON specification. If the string contains errors, the parser fails and returns a descriptive error message.

This challenge corresponds to the challenge from [Coding Challenges](https://codingchallenges.fyi/challenges/challenge-json-parser). 


## Prerequisite / Setup

1. Make sure to have ruby installed in your system.
2. Run `bundle install` from the repository's root directory to install dependencies.
3. Optional: Add the executable `bin/json_parser` in your PATH, to directly run the command from anywhere.


## Usage

NOTE: All the files in the below examples are used from the repository's directory: `./test/json_files/`

```bash
[$]> cat ./test/json_files/step2/valid2.json
{
  "key": "value",
  "key2": "value"
}
[$]> bin/json_parser ./test/json_files/step2/valid2.json
{"key"=>"value", "key2"=>"value"}


[$]> cat ./test/json_files/step3/valid.json
{
  "key1": true,
  "key2": false,
  "key3": null,
  "key4": "value",
  "key5": 101
}
[$]> bin/json_parser ./test/json_files/step3/valid.json
{"key1"=>true, "key2"=>false, "key3"=>nil, "key4"=>"value", "key5"=>101}


[$]> cat ./test/json_files/step4/valid2.json
{
  "key": "value",
  "key-n": 101,
  "key-o": {
    "inner key": "inner value"
  },
  "key-l": ["list value1", "list value2"]
}
[$]> bin/json_parser ./test/json_files/step4/valid2.json
{"key"=>"value", "key-n"=>101, "key-o"=>{"inner key"=>"inner value"}, "key-l"=>["list value1", "list value2"]}
```

## Error Handling

NOTE: All the files in the below examples are used from the repository's directory: `./test/json_files/`

```bash
[$]> cat ./test/json_files/step1/invalid.json

[$]> bin/json_parser ./test/json_files/step1/invalid.json
bin/json_parser: File is empty (RuntimeError)


[$]> cat ./test/json_files/step2/invalid.json
{"key": "value",}
[$]> bin/json_parser ./test/json_files/step2/invalid.json
bin/json_parser: Expected next string key (RuntimeError)


[$]> cat ./test/json_files/step2/invalid2.json
{
  "key": "value",
  key2: "value"
}
[$]> bin/json_parser ./test/json_files/step2/invalid2.json
bin/json_parser: Unable to parse at  (RuntimeError)
  key2: "value"
}


[$]> cat ./test/json_files/step2/invalid3.json
{
  "key": "value",
  "key2" "value"
}
[$]> bin/json_parser ./test/json_files/step2/invalid3.json
bin/json_parser: Expected colon (RuntimeError)


[$]> cat ./test/json_files/step3/invalid.json
{
  "key1": true,
  "key2": False,
  "key3": null,
  "key4": "value",
  "key5": 101
}
[$]> bin/json_parser ./test/json_files/step3/invalid.json
bin/json_parser: Unable to parse at  False, (RuntimeError)
  "key3": null,
  "key4": "value",
  "key5": 101
}


[$]> cat ./test/json_files/step4/invalid.json
{
  "key": "value",
  "key-n": 101,
  "key-o": {
    "inner key": "inner value"
  },
  "key-l": ['list value']
}
[$]> bin/json_parser ./test/json_files/step4/invalid.json
bin/json_parser: Unable to parse at 'list value'] (RuntimeError)
}


[$]> cat ./test/json_files/step4/invalid2.json
{
  "key": "value",
  "key-n": 101,
  "key-o": {}
  "key-l": []
}
[$]> bin/json_parser ./test/json_files/step4/invalid2.json
bin/json_parser: Expected comma or closing brace (RuntimeError)


[$]> cat ./test/json_files/step4/invalid3.json
{
  "key": "value",
  "key-n": 101,
  "key-l": ["list value1", "list value2",],
  "key-o": {
    "inner key": "inner value"
  }
}
[$]> bin/json_parser ./test/json_files/step4/invalid3.json
bin/json_parser: Expected next string key (RuntimeError)


[$]> cat ./test/json_files/step4/invalid4.json
{
  "key": "value",
  "key-n": 101,
  "key-l": ["list value1" "list value2"],
  "key-o": {
    "inner key": "inner value"
  }
}
[$]> bin/json_parser ./test/json_files/step4/invalid4.json
bin/json_parser: Expected comma or closing bracket (RuntimeError)


## License

[MIT](LICENSE) © Shivang Yadav

First run `bundle install` to install gems

To use the lib, run `ruby lib/lib.rb`: this file will convert `./data.json` to CSV
The CSV output is on `./result/result.csv`

Only Json composed with arrays of hahses can be transformed to csv.
Hashes must have the same structure.

Some examples:
json_data = `[
  {"a":
    { "b": 1}
  },
  { "c": 2},
  "d": ['hello', 'hi']
]`

csv output:

`a.b,c,d`

`1,2,"hello,hi"`

To run the tests, run `bundle exec specs`

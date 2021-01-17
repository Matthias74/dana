require "json"
require_relative 'json_to_csv'

file = File.read('./data.json')
data = JSON.parse(file)
JSONtoCSV.new(data).execute!



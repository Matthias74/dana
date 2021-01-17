require "json"
require "json_to_csv"

describe JSONtoCSV do
  it "returns the good number of lines" do
    file = File.read('./data.json')
    data = JSON.parse(file)
    expect {
      JSONtoCSV.new(data).execute!
    }.not_to raise_error
    result = JSONtoCSV.new(data).execute!
    expect(data.length).to eq(result.length)
  end

  it "raises an error if data is not an array of hashes" do
    expect {
      JSONtoCSV.new([1,2]).execute!
    }.to raise_error("The data should be an array of hashes")
    expect{
      JSONtoCSV.new({}).execute!
    }.to raise_error("The data should be an array of hashes")
  end

  it "raises an error if data doesn't follow the same schema" do
    expect{
      JSONtoCSV.new([
        {
          hello: 1
        },
        {
          goodbye: 1
        }
      ]).execute!
    }.to raise_error("The hash keys must be the same for each element")
  end
end

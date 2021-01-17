require 'csv'

class JSONtoCSV
  attr_reader :data, :raw_headers

  def initialize(data)
    @data = data
  end

  def execute!
    check_data_consistency

    headers = raw_headers

    rows = @data.map do |row|
      headers.map do |header|
        value = row.dig(*header.split(".").map { |v| v })
        value = "#{value.join(',')}" if value.is_a?(Array)
        value
      end
    end

    CSV.open("./result/result.csv", "w") do |csv|
      csv << headers
      rows.each do |row|
        csv << row
      end
    end
  end

  private

  def build_raw_headers(data)
    data.each_with_object([]) do |(key, value), memo|
      if value.is_a? Hash
        build_raw_headers(value).each do |memo_key, memo_value|
          memo.push("#{key}.#{memo_key}")
        end
      else
        memo.push(key.to_s)
      end
    end
  end

  def check_data_consistency
    raise InconsistentData.new if !data.is_a?(Array)
    raise InconsistentData.new if data.find { |element| !element.is_a?(Hash) }
    raise InconsistentDataSchema.new if data.map { |element| @raw_headers = build_raw_headers(element) }.uniq.length > 1
  end
end


class InconsistentData < StandardError
  def to_s
    "The data should be an array of hashes"
  end
end

class InconsistentDataSchema < StandardError
  def to_s
    "The hash keys must be the same for each element"
  end
end

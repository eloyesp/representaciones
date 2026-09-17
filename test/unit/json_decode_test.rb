# frozen_string_literal: true

require "test_helper"

# json 3.0 removed the positional options argument from JSON.parse while
# ActiveSupport <= 8.1.3 still passes it, breaking session cookie decryption.
# config/initializers/json.rb restores the legacy signature; guard that here.
class JsonDecodeTest < ActiveSupport::TestCase
  test "ActiveSupport::JSON.decode parses JSON" do
    assert_equal({ "a" => 1 }, ActiveSupport::JSON.decode('{"a":1}'))
  end

  test "ActiveSupport::JSON.decode forwards keyword options" do
    assert_equal({ a: 1 }, ActiveSupport::JSON.decode('{"a":1}', symbolize_names: true))
  end
end
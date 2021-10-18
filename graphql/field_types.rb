require "graphql"

module FieldTypes
  class EncodedBlob < GraphQL::Schema::Scalar
    description "A valid blob, transported as a string"

    def self.coerce_input(input_value, context)
      input_value
    end

    def self.coerce_result(ruby_value, context)
      ruby_value.force_encoding("ASCII-8BIT").encode("UTF-8")
    rescue Encoding::UndefinedConversionError
      "ERROR: Could not be encoded to UTF-8"
    end
  end
end

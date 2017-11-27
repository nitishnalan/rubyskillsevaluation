require 'spec_helper'

describe Quote do
  %w(
    departure_date
    return_date
    total_trip_cost
  ).each do |attribute_name|
    describe "##{attribute_name}=" do
      let (:quote) { Quote.new }

      it "should set a value for #{attribute_name} that is accessible by the reader of the same name" do
        quote.send("#{attribute_name}=", "abc")
        expect( quote.send(attribute_name)).to eq("abc")
      end
    end
  end
end

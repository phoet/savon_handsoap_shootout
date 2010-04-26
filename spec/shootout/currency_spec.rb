require "spec_helper"

describe "currency" do
  before { @from, @to = "USD", "EUR" }

  [Shootout::Soap4rCurrency, Shootout::SavonCurrency, Shootout::HandsoapCurrency].each do |clazz|
    describe "#{clazz} for conversion" do
      it "should return a valid conversion rate" do
        conversion_rate = clazz.conversion_rate @from, @to
        conversion_rate.should be_a String
        conversion_rate.should_not be_empty
      end
    end
  end

end

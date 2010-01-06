require "spec_helper"

describe "currency" do
  before { @from, @to = "USD", "EUR" }

  describe "Savon" do
    it "should return a valid conversion rate" do
      conversion_rate = Shootout::SavonCurrency.conversion_rate @from, @to
      conversion_rate.should be_a String
      conversion_rate.should_not be_empty
    end
  end

  describe "Handsoap" do
    it "should return a valid conversion rate" do
      conversion_rate = Shootout::HandsoapCurrency.conversion_rate @from, @to
      conversion_rate.should be_a String
      conversion_rate.should_not be_empty
    end
  end

end

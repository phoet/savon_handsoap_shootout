require "spec_helper"

describe "iban" do
  before { @iban = "DE47200505501280133503" }

  describe "Savon" do
    it "should return the validation result for an IBAN" do
      validation_result = Shootout::SavonIBAN.validate @iban
      validation_result.should eql "VALID" unless validation_result == "Daily Free Usage Limit Exceeded"
    end
  end

  describe "Handsoap" do
    it "should return the validation result for an IBAN" do
      validation_result = Shootout::HandsoapIBAN.validate @iban
      validation_result.should eql "VALID" unless validation_result == "Daily Free Usage Limit Exceeded"
    end
  end

end

require "spec_helper"

describe "iban" do
  before { @iban = "DE47200505501280133503" }

  [Shootout::Soap4rIBAN, Shootout::SavonIBAN, Shootout::HandsoapIBAN].each do |clazz|
    describe "#{clazz} for iban" do
      it "should return the validation result for an IBAN for class #{clazz}" do
        validation_result = clazz.validate @iban
        validation_result.should eql "VALID" unless validation_result == "Daily Free Usage Limit Exceeded"
      end
    end
  end

end

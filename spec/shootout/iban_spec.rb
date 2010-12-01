require "spec_helper"

describe "iban" do
  [Shootout::Soap4rIBAN, Shootout::SavonIBAN, Shootout::HandsoapIBAN].each do |clazz|
    it "should return the validation result for an IBAN for class #{clazz}" do
      validation_result = clazz.validate 'DE47200505501280133503'
      validation_result.should eql "VALID"
    end
  end
end

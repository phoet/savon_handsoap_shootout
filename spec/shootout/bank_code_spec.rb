require "spec_helper"

describe "bank_code" do
  [Shootout::Soap4rBankCode, Shootout::SavonBankCode, Shootout::HandsoapBankCode].each do |clazz|
    it "should return the corrent zip code for a given bank for #{clazz}" do
      zip_code = clazz.zip_code '24050110'
      zip_code.should eql '21309'
    end
  end
end

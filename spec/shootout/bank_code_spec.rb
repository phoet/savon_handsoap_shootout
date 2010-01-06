require "spec_helper"

describe "bank_code" do
  before { @bank_code, @zip_code = "24050110", "21309" }

  describe "Savon" do
    it "should return the corrent zip code for a given bank" do
      zip_code = Shootout::SavonBankCode.zip_code @bank_code
      zip_code.should eql @zip_code
    end
  end

  describe "Handsoap" do
    it "should return the corrent zip code for a given bank" do
      zip_code = Shootout::HandsoapBankCode.zip_code @bank_code
      zip_code.should eql @zip_code
    end
  end

end

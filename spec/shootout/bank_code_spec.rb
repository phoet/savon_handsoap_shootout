require "spec_helper"

describe "bank_code" do
  before { @bank_code, @zip_code = "24050110", "21309" }

  [Shootout::SavonBankCode, Shootout::SavonBankCode, Shootout::HandsoapBankCode].each do |clazz|
    describe "#{clazz} for zip" do
      it "should return the corrent zip code for a given bank" do
        zip_code = clazz.zip_code @bank_code
        zip_code.should eql @zip_code
      end
    end
  end

end

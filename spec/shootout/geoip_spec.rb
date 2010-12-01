require "spec_helper"

describe "bank_code" do
  [Shootout::Soap4rGeoIP, Shootout::SavonGeoIP, Shootout::HandsoapGeoIP].each do |clazz|
    it "should return the corrent zip code for a given bank for #{clazz}" do
      country = clazz.geo_ip '193.99.144.85'
      country.should eql 'Germany'
    end
  end
end

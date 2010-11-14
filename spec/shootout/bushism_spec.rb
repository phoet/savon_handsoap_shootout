require "spec_helper"

describe "bushism" do
  [Shootout::Soap4rBushism, Shootout::SavonBushism, Shootout::HandsoapBushism].each do |clazz|
      it "should return a random bushism for class #{clazz}" do
        cite, cite_context = clazz.bushism
        puts "George W. Bush said: '#{cite}'"
        cite.should_not be nil
        cite_context.should_not be nil
      end
  end
end

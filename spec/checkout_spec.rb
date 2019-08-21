RSpec.describe RubyBilling::Checkout do
  describe ".total" do
    it "returns 0 for no items" do
      co = RubyBilling::Checkout.new(nil)

      expect(co.total).to eq(0)
    end
  end
end

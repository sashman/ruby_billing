RSpec.describe RubyBilling::Checkout do
  describe ".total" do
    context "without promotions" do
      before do
        @co = RubyBilling::Checkout.new(nil)
      end

      it "returns 0 for no items" do
        expect(@co.total).to eq(0)
      end

      it "returns total price for multiple items" do
        item = RubyBilling::Item.new("001", "test", 100)
        @co.scan(item)
        @co.scan(item)
        @co.scan(item)

        expect(@co.total).to eq(Money.new(300))
      end
    end
  end
end

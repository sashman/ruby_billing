RSpec.describe RubyBilling::Checkout do
  describe ".total" do
    it "returns 0 for no items" do
      co = RubyBilling::Checkout.new(nil)

      expect(co.total).to eq(0)
    end

    it "returns total price for multiple items w/o promotions" do
      co = RubyBilling::Checkout.new(nil)
      item = RubyBilling::Item.new("001", "test", 100)
      co.scan(item)

      expect(co.total).to eq(Money.new(100))
    end
  end
end

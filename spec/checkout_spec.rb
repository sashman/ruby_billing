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

    context "with total threshold promotion" do
      before do
        promotions = RubyBilling::PromotionalRules.new

        half_price_threshold_rule =
          RubyBilling::TotalThresholdRule.new(true, Money.new(100)) do |total|
            total / 2
          end

        promotions.add_total_threshold_rule(half_price_threshold_rule)

        @co = RubyBilling::Checkout.new(promotions)
      end

      it "returns 0 for no items" do
        expect(@co.total).to eq(0)
      end

      it "returns normal price for not over 100 total" do
        item = RubyBilling::Item.new("001", "test", 100)
        @co.scan(item)

        expect(@co.total).to eq(Money.new(100))
      end

      it "returns half price for over 100 total" do
        item = RubyBilling::Item.new("001", "test", 100)
        @co.scan(item)
        @co.scan(item)
        @co.scan(item)

        expect(@co.total).to eq(Money.new(150))
      end
    end
  end
end

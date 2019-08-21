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

    context "with item list based promotion" do
      before do
        promotions = RubyBilling::PromotionalRules.new

        half_price_001_list_rule =
          RubyBilling::ProductQuantityThresholdRule.new("001", true, 3) do |items|
            items.map do |item|
              if item.product_code == "001"
                RubyBilling::Item.new("001", "test", item.price / 2)
              else
                item
              end
            end
          end

        promotions.add_item_list_rule(half_price_001_list_rule)

        @co = RubyBilling::Checkout.new(promotions)
      end

      it "returns 0 for no items" do
        expect(@co.total).to eq(0)
      end

      it "returns normal price for not over 3 001 items" do
        item = RubyBilling::Item.new("001", "test", 100)
        @co.scan(item)

        expect(@co.total).to eq(Money.new(100))
      end

      it "returns half price 001s for over 3 of them in the list" do
        item = RubyBilling::Item.new("001", "test", 100)
        @co.scan(item)
        @co.scan(item)
        @co.scan(item)
        @co.scan(item)

        item = RubyBilling::Item.new("002", "test", 100)
        @co.scan(item)

        expect(@co.total).to eq(Money.new(300))
      end
    end
  end
end

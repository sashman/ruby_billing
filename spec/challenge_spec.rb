RSpec.describe RubyBilling::Checkout do
  describe ".total" do
    context "with promotion combination" do
      before do
        promotions = RubyBilling::PromotionalRules.new

        percent_threshold_rule =
          RubyBilling::TotalThresholdRule.new(true, Money.new(6000)) do |total|
            total * 0.9
          end

        product_code = "001"
        price_reduction_001_list_rule =
          RubyBilling::ProductQuantityThresholdRule.new(product_code, true, 1) do |items|
            items.map do |item|
              if item.product_code == product_code
                RubyBilling::Item.new(product_code, "test", 850)
              else
                item
              end
            end
          end

        promotions.add_total_threshold_rule(percent_threshold_rule)
        promotions.add_item_list_rule(price_reduction_001_list_rule)

        @co = RubyBilling::Checkout.new(promotions)
        @item001 = RubyBilling::Item.new("001", "Lavender heart", 925)
        @item002 = RubyBilling::Item.new("002", "Personalised cufflinks", 4500)
        @item003 = RubyBilling::Item.new("003", "Kids T-shirt", 1995)
      end

      it "Basket: 001,002,003 Total: £66.78" do
        @co.scan(@item001)
        @co.scan(@item002)
        @co.scan(@item003)

        expect(@co.total).to eq(Money.new(6678))
      end

      it "Basket: 001,003,001 Total: £36.95" do
        @co.scan(@item001)
        @co.scan(@item003)
        @co.scan(@item001)

        expect(@co.total).to eq(Money.new(3695))
      end

      it "Basket: 001,002,001,003 Total: £73.76" do
        @co.scan(@item001)
        @co.scan(@item002)
        @co.scan(@item001)
        @co.scan(@item003)

        expect(@co.total).to eq(Money.new(7376))
      end
    end
  end
end

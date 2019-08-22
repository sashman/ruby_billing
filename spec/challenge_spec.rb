RSpec.describe RubyBilling::Checkout do
  describe ".total" do
    context "with promotion combination" do
      before do
        promotions = RubyBilling::PromotionalRules.new

        promotions.add_total_threshold_rule(RubyBilling::TOTAL_10_PERCENT_OFF_PROMOTION)
        promotions.add_item_list_rule(RubyBilling::LAVENDER_HEART_PROMOTION)

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

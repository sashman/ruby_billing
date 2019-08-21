module RubyBilling
  class Checkout
    def initialize(promotional_rules)
      @promotional_rules = promotional_rules
      @items = []
    end

    def scan(item)
      @items.push(item)
    end

    def total
      @items
        .map(&:price)
        .inject { |sum, price| sum + price }
    end
  end
end
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
      return Money.new(0) if @items.empty?

      total = @items
        .map(&:price)
        .inject { |sum, price| sum + price }

      return total unless @promotional_rules
      
      @promotional_rules.calculate_total(total)
    end
  end
end
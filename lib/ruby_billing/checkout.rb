module RubyBilling
  class Checkout
    def initialize(promotional_rules)
      @promotional_rules = promotional_rules
    end

    def scan(item)
    end

    def total
      0
    end
  end
end
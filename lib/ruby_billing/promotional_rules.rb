module RubyBilling
  class PromotionalRules
    def initialize
      @per_product_rules = []
      @total_threshold_rules = []
    end

    def add_per_product_rule(rule)
      @per_product_rules.push(rule)
    end

    def add_total_threshold_rule(rule)
      @total_threshold_rules.push(rule)
    end
  end
end
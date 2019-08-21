module RubyBilling
  class PromotionalRules
    def initialize
      @item_list_rules = []
      @total_threshold_rules = []
    end

    def add_item_list_rule(rule)
      @item_list_rules.push(rule)
    end

    def amend_items(item_list)
      return item_list if @item_list_rules.empty?

      @item_list_rules
        .inject(item_list) { |list, rule| rule.execute(list) }
    end

    def add_total_threshold_rule(rule)
      @total_threshold_rules.push(rule)
    end

    def calculate_total(total)
      return total if @total_threshold_rules.empty?

      @total_threshold_rules
        .inject(total) { |subtotal, rule| rule.execute(subtotal) }
    end
  end
end
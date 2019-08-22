require "ruby_billing/version"
require "ruby_billing/checkout"
require "ruby_billing/item"
require "ruby_billing/promotional_rules"
require "ruby_billing/total_threshold_rule"
require "ruby_billing/product_quantity_threshold_rule"
require "money"

module RubyBilling
  Money.default_currency = Money::Currency.new("GBP")

  class Error < StandardError; end

  TOTAL_10_PERCENT_OFF_PROMOTION =
    RubyBilling::TotalThresholdRule.new(true, Money.new(6000)) do |total|
      total * 0.9
    end

  LAVENDER_HEART_PROMOTION =
    RubyBilling::ProductQuantityThresholdRule.new("001", true, 1) do |items|
      items.map do |item|
        if item.product_code == "001"
          RubyBilling::Item.new("001", "test", 850)
        else
          item
        end
      end
    end
end

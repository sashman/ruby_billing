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
  # Your code goes here...
end

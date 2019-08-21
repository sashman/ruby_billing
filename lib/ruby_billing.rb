require "ruby_billing/version"
require "ruby_billing/checkout"
require "ruby_billing/item"
require "money"

module RubyBilling
  Money.default_currency = Money::Currency.new("GBP")

  class Error < StandardError; end
  # Your code goes here...
end

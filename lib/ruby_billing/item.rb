module RubyBilling
  class Item
    def initialize(product_code, name, price_pennies)
      @product_code = product_code
      @name = name
      @price = Money.new(price_pennies)
    end

    def price
      @price
    end

    def product_code
      @product_code
    end
  end
end
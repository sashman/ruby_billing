module RubyBilling
  class ProductQuantityThresholdRule
    def initialize(product_code, above, value, &action)
      @product_code = product_code
      @above = above
      @value = value
      @action = action
    end

    def execute(item_list)
      product_quantity = item_list.select do |item|
        item.product_code == @product_code
      end.count

      return @action.call(item_list) if @above && product_quantity > @value
      return @action.call(item_list) if !@above && product_quantity <= @value

      item_list
    end
  end
end
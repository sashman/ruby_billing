module RubyBilling
  class TotalThresholdRule
    def initialize(above, value, &action)
      @above = above
      @value = value
      @action = action
    end

    def execute(total)
      return @action.call(total) if @above && total > @value
      return @action.call(total) if !@above && total <= @value

      total
    end
  end
end
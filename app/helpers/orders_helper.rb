module OrdersHelper
  def total_sum(orders)
    orders.inject(0) { |sum, order| sum + order.courses.sum(:price) }
  end
end

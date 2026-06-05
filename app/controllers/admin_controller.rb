class AdminController < ApplicationController
  layout "admin"
  def index
    @total_orders = Order.count
    @total_users = User.count
    @recent_orders = Order.order(created_at: :desc).limit(5)
  end
end

class StoreController < ApplicationController
  include CurrentCart
  before_action :set_cart
  def index
    @products = Product.order(:title)
    session[:visit_count] ||= 0  # Initialize to 0 if it doesn’t exist
    session[:visit_count] += 1   # Increment by 1 on every visit
    @visit_count = session[:visit_count]
  end
end

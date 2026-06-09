class StoreController < ApplicationController
  include CurrentCart
  allow_unauthenticated_access
  before_action :set_cart
  def index
    if params[:set_locale]
      redirect_to store_index_path(locale: params[:set_locale])
    else
      @products = Product.order(:title)
    end
    # session[:visit_count] ||= 0  # Initialize to 0 if it doesn’t exist
    # session[:visit_count] += 1   # Increment by 1 on every visit
    # @visit_count = session[:visit_count]
  end
end

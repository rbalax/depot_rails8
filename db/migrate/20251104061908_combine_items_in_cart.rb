class CombineItemsInCart < ActiveRecord::Migration[8.0]
  def up
    # Iterate over all carts in the database
    Cart.all.each do |cart|
      # Count the total quantity of each product in the cart
      sums = cart.line_items.group(:product_id).sum(:quantity)

      # For each product in the cart, check if its total quantity > 1
      sums.each do |product_id, quantity|
        if quantity > 1
          # Delete all line items for this product
          cart.line_items.where(product_id: product_id).delete_all

          # Create a new line item with the total quantity
          item = cart.line_items.build(product_id: product_id)
          item.quantity = quantity
          item.save!
        end
      end
    end
  end

  def down
    # Split items with quantity > 1 into multiple items
    LineItem.where("quantity > 1").each do |line_item|
      line_item.quantity.times do
        LineItem.create!(
          cart_id: line_item.cart_id,
          product_id: line_item.product_id,
          quantity: 1
        )
      end

      # Remove the original combined item
      line_item.destroy
    end
  end
end

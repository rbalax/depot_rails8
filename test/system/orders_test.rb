require "application_system_test_case"
include ActiveJob::TestHelper

class OrdersTest < ApplicationSystemTestCase
  test "check dynamic fields" do
    visit store_index_url

    click_on "Add to Cart", match: :first
    click_on "Checkout"

    assert has_no_field? "Routing number"
    assert has_no_field? "Account number"
    assert has_no_field? "Credit card number"
    assert has_no_field? "Expiration date"
    assert has_no_field? "Po number"

    select "Check", from: "Pay type"

    assert has_field? "Routing number"
    assert has_field? "Account number"
    assert has_no_field? "Credit card number"
    assert has_no_field? "Expiration date"
    assert has_no_field? "Po number"

    select "Credit Card", from: "Pay type"

    assert has_no_field? "Routing number"
    assert has_no_field? "Account number"
    assert has_field? "Credit card number"
    assert has_field? "Expiration date"
    assert has_no_field? "Po number"

    select "Purchase Order", from: "Pay type"

    assert has_no_field? "Routing number"
    assert has_no_field? "Account number"
    assert has_no_field? "Credit card number"
    assert has_no_field? "Expiration date"
    assert has_field? "Po number"
  end

  require "application_system_test_case"

class CheckoutFlowTest < ApplicationSystemTestCase
  include ActiveJob::TestHelper

  def setup
    ActionMailer::Base.deliveries.clear
  end

  test "check order and delivery" do
    perform_enqueued_jobs do
      visit store_index_url

      click_on "Add to Cart", match: :first
      click_on "Checkout"

      fill_in "Name", with: "Dave Thomas"
      fill_in "Address", with: "123 Main Street"
      fill_in "Email", with: "dave@example.com"

      select "Check", from: "Pay type"
      fill_in "Routing number", with: "123456"
      fill_in "Account number", with: "987654"

      click_button "Place Order"

      assert_text "Thank you for your order"
    end

    # ---- Order assertions (state) ----
    order = Order.last
    assert_equal "Dave Thomas", order.name
    assert_equal "123 Main Street", order.address
    assert_equal "dave@example.com", order.email
    assert_equal "Check", order.pay_type
    assert_equal 1, order.line_items.size

    # ---- Email assertions (side effect) ----
    assert_equal 1, ActionMailer::Base.deliveries.size

    mail = ActionMailer::Base.deliveries.last
    assert_equal [ "dave@example.com" ], mail.to
    assert_equal "Sam Ruby <depot@example.com>", mail[:from].value
    assert_equal "Pragmatic Store Order Confirmation", mail.subject
  end
end
end

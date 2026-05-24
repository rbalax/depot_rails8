require "application_system_test_case"

class StoreTest < ApplicationSystemTestCase
  test "cart visibility toggles correctly" do
    visit store_index_url

    assert_no_text "Your Cart"

    click_on "Add to Cart", match: :first

    assert_text "Your Cart"

    click_on "Empty Cart"

    assert_no_text "Your Cart"
  end

  test "new cart items are highlighted" do
    visit store_index_url

    click_on "Add to Cart", match: :first

    assert_css ".line-items-highlight"
  end
end

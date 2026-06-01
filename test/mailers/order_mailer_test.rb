require "test_helper"

class OrderMailerTest < ActionMailer::TestCase
  test "received" do
    mail = OrderMailer.received(orders(:one))

    assert_equal "Pragmatic Store Order Confirmation", mail.subject
    assert_equal [ "dave@example.org" ], mail.to
    assert_equal [ "rbalax@yahoo.co.uk" ], mail.from
    assert_match /1 x The Pragmatic Programmer/, mail.body.encoded
  end

  test "shipped" do
  mail = OrderMailer.shipped(orders(:one))

  assert_equal "Pragmatic Store Order Shipped", mail.subject
  assert_equal [ "dave@example.org" ], mail.to
  assert_equal [ "rbalax@yahoo.co.uk" ], mail.from

  html = mail.body.parts.find { |p| p.content_type.match?(/html/) }.body.decoded

  assert_match %r{
    <td[^>]*>\s*1\s*&times;\s*</td>\s*
    <td[^>]*>\s*The\s+Pragmatic\s+Programmer\s*</td>
  }mx, html
end
end

require 'test_helper'

class UserMailerTest < ActionMailer::TestCase
  # replace this with your real tests
  test "welcome_email" do
   user=users(:dave)
    email = UserMailer.deliver_welcome_email(user)
   assert !ActionMailer::Base.deliveries.empty?

    assert_equal [user.email],email.to
    assert_equal "welcome",email.subject
   
    
  end
end

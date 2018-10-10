
class UserMailerPreview < ActionMailer::Preview
  def order_email
    UserMailer.order_email(@user).deliver_now
  end
end
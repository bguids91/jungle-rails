
class UserMailerPreview < ActionMailer::Preview
  def order_email
    UserMailer.with(user: User.first).order_email
  end
end
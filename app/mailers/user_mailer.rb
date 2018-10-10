class UserMailer < ApplicationMailer
  default from: "no-reply@jungle.com"

  def order_email(user)
    @user = user
    @url  = 'http://localhost:3000/login'
    mail(to: @user.email, subject: 'Order from the Jungle')
  end

end

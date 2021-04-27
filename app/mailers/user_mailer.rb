class UserMailer < ApplicationMailer
  def account_activation(user)
    @user = user
    mail to: user.email, subject: '【重要】MOVEよりアカウント有効化のためのメールを送信しました'
  end

  def password_reset
    @greeting = 'Hi'

    mail to: 'to@example.org'
  end
end

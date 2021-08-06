class ContactMailer < ApplicationMailer
  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.contact_mailer.user_email.subject
  #
  def user_email(name:, email:)
    @name = name
    mail(
      to: email,
      subject: '【アプリ名】お問い合わせを受付いたしました'
    )
  end

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.contact_mailer.admin_email.subject
  #
  def admin_email; end
end

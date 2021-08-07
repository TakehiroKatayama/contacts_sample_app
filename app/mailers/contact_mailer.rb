class ContactMailer < ApplicationMailer
  ADMIN_EMAIL = 'admin@example.com'

  def user_email(contact)
    @contact = contact
    @name = contact.name.present? ? contact.name : contact.email
    subject = '【アプリ名】お問い合わせを受付いたしました'

    mail(to: contact.email, subject: subject)
  end

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.contact_mailer.admin_email.subject
  #
  def admin_email(contact)
    @contact = contact
    @name = contact.name.present? ? contact.name : contact.email
    subject = '【アプリ名】お問い合わせがありました'

    mail(to: ADMIN_EMAIL, subject: subject)
  end
end

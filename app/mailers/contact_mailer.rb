class ContactMailer < ApplicationMailer
  def contact_mail(contact)
    @contact = contact
    # 下記を確認
    mail to: "yusei.onigiri@gmail.com", subject: "お問い合わせの確認メール"
  end
end

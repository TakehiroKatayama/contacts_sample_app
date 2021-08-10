class ContactsController < ApplicationController
  def index
    @contact = Contact.new
  end

  def create
    @contact = Contact.new(contact_params)

    if @contact.save
      # ユーザーにメールを送信
      ContactMailer.user_email(@contact).deliver_now
      # 管理者にメールを送信
      ContactMailer.admin_email(@contact).deliver_now
      # slackに通知を送る
      notify_to_slack(@contact)
      redirect_to root_path
    else
      render :index
    end
  end

  def notify_to_slack(contact)
    message = <<~EOS
      新しいお問い合わせがありました！
      ```
      name: #{contact.name}様
      email: #{contact.email}
      phonenumber: #{contact.phonenumber}
      message: #{contact.message}
      ```
    EOS

    notifier = Slack::Notifier.new(
      ENV['SLACK_WEBHOOK_URL'],
      channel: "##{ENV['SLACK_CHANNEL']}",
      username: 'お問い合わせ通知'
    )
    notifier.ping message
  end

  private

  # IPアドレスをパラメータに追加
  def contact_params
    params.require(:contact)
          .permit(:name, :email, :phonenumber, :message, :submitted, :confirmed)
          .merge(remote_ip: request.remote_ip)
  end
end

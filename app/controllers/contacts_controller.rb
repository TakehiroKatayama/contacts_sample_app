class ContactsController < ApplicationController
  def index
    @contact = Contact.new
  end

  def create
    @contact = Contact.new(contact_params)

    respond_to do |format|
      if @contact.save
        # ユーザーにメールを送信
        ContactMailer.user_email(@contact).deliver_now
        # 管理者にメールを送信
        ContactMailer.admin_email(@contact).deliver_now
        notify_to_slack(@contact)
        format.html { redirect_to root_path, notice: 'Contact was successfully created.' }
        format.json { render :index, status: :created, location: @contact }
        # redirect_to root_path
      else
        format.html { render :index, status: :unprocessable_entity }
        format.json { render json: @contact.errors, status: :unprocessable_entity }
        # render :index
      end
    end
  end

  def notify_to_slack(contact)
    message = <<~EOS
      新しいお問い合わせがありました！
      ```
      name: #{contact.name}
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

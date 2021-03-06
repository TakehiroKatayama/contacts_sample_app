class CreateContacts < ActiveRecord::Migration[6.1]
  def change
    create_table :contacts do |t|
      t.string :name
      t.string :email
      t.string :phonenumber
      t.text :message
      t.inet :remote_ip

      t.timestamps
    end
  end
end

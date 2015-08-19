class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|

      t.timestamps
      t.string :user_name, null: false
      t.string :password_digest, null: false
      t.string :session_token, null: false, index: true, unique: true

    end
  end
end

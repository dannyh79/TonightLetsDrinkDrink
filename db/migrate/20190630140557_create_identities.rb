class CreateIdentities < ActiveRecord::Migration[5.2]
  def change
    create_table :identities do |t|
      t.references :user, foreign_key: true
      t.string :provider  # 用來存取第三方登入的來源
      t.string :uid  # 用來存取第三方登入的 user_id

      t.timestamps
    end
  end
end

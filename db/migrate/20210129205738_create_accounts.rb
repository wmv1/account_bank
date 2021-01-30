class CreateAccounts < ActiveRecord::Migration[6.1]
  def change
    create_table :accounts do |t|
      t.string :account_id
      t.string :account_name
      t.float :balance
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end

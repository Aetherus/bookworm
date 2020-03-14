class CreateAccounts < ActiveRecord::Migration[6.0]
  def change
    create_table :accounts do |t|
      t.string :number
      t.decimal :initial_balance
      t.string :holder_name

      t.timestamps
    end
  end
end

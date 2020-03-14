class CreateLoans < ActiveRecord::Migration[6.0]
  def change
    create_table :loans do |t|
      t.belongs_to :account, null: false, foreign_key: true
      t.belongs_to :book, null: false, foreign_key: true
      t.decimal :fee, null: false, default: 0
      t.timestamp :concluded_at

      t.timestamps

      t.index :concluded_at
    end
  end
end

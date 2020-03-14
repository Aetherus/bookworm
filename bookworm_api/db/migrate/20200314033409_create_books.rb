class CreateBooks < ActiveRecord::Migration[6.0]
  def change
    create_table :books do |t|
      t.string :isbn, null: false
      t.string :title, null: false
      t.string :author
      t.date :published_on
      t.integer :quantity, null: false, default: 0

      t.timestamps

      t.index :isbn, unique: true
    end
  end
end

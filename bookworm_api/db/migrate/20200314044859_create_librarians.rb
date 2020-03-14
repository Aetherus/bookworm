class CreateLibrarians < ActiveRecord::Migration[6.0]
  def change
    create_table :librarians do |t|
      t.string :email, null: false
      t.string :password_digest, null: false
      t.string :name, null: false

      t.timestamps

      t.index :email, unique: true
    end
  end
end

class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.string :email
      t.string :password_digest
      t.integer :ratings_count
      t.integer :favorites_count
      t.integer :comments_count

      t.timestamps
    end
  end
end

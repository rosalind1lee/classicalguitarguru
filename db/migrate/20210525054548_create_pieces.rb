class CreatePieces < ActiveRecord::Migration[6.0]
  def change
    create_table :pieces do |t|
      t.string :title
      t.integer :composer_id
      t.integer :arranger_id
      t.integer :ratings_count
      t.integer :favorites_count
      t.integer :comments_count

      t.timestamps
    end
  end
end

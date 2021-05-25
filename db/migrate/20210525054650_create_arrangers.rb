class CreateArrangers < ActiveRecord::Migration[6.0]
  def change
    create_table :arrangers do |t|
      t.string :name
      t.integer :pieces_count

      t.timestamps
    end
  end
end

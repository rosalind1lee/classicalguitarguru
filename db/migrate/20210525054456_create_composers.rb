class CreateComposers < ActiveRecord::Migration[6.0]
  def change
    create_table :composers do |t|
      t.string :name
      t.string :era
      t.integer :pieces_count

      t.timestamps
    end
  end
end

class ChangeDefaultInRemainingTables < ActiveRecord::Migration[6.0]
  def change
    change_column_default :composers, :pieces_count, 0
    change_column_default :pieces, :ratings_count, 0
    change_column_default :pieces, :favorites_count, 0
    change_column_default :pieces, :comments_count, 0
  end
end

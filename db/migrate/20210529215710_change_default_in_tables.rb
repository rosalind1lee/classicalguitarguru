class ChangeDefaultInTables < ActiveRecord::Migration[6.0]
  def change
    change_column_default :arrangers, :pieces_count, 0
  end
end

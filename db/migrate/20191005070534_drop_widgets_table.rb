class DropWidgetsTable < ActiveRecord::Migration[6.0]
  def up
    drop_table :widgets
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end

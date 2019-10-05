class CreateWidgets < ActiveRecord::Migration[6.0]
  def change
    create_table :widgets do |t|
      t.string :name
      t.string :url
      t.string :apikey
      t.boolean :active
      t.timestamps
    end
  end
end

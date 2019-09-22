class CreateGlobalapis < ActiveRecord::Migration[5.2]
  def change
    create_table :globalapis do |t|
      t.string :name
      t.string :url
      t.string :api
      t.boolean :active

      t.timestamps
    end
  end
end

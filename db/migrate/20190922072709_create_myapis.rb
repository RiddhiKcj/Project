class CreateMyapis < ActiveRecord::Migration[5.2]
  def change
    create_table :myapis do |t|
      t.string :name
      t.string :url
      t.string :api
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end

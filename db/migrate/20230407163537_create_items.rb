class CreateItems < ActiveRecord::Migration[6.0]
  def change
    create_table :items do |t|
      t.string :name
      t.date :purchase_date
      t.date :expiration_date
      t.integer :quantity
      t.text :description
      t.string :image
      t.string :location
      t.integer :category_id

      t.timestamps
    end
  end
end

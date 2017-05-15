class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :title
      t.text :description
      t.decimal :price
      t.boolean :featured
      t.string :image_file_name
      t.integer :duration

      t.timestamps
    end
    add_index :products, :featured
    add_index :products, :duration
  end
end

class CreateBooks < ActiveRecord::Migration[5.0]
  def change
    create_table :books do |t|
      t.string :typeBook
      t.text :category
      t.float :price
      t.text :name
      t.text :author
      t.string :isbn
      t.integer :pages
      t.text :publisher
      t.string :poster_url

      t.timestamps
    end
  end
end

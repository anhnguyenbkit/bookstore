class CreateAddImageToBooks < ActiveRecord::Migration[5.0]
  def change
    add_attachment :books, :image
    create_table :add_image_to_books do |t|

      t.timestamps
    end
  end
end

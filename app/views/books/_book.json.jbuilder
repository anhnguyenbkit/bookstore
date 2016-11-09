json.extract! book, :id, :type, :category, :price, :name, :author, :isbn, :pages, :publisher, :created_at, :updated_at
json.url book_url(book, format: :json)
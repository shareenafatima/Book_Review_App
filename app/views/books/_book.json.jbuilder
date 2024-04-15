json.extract! book, :id, :title, :description, :author, :publication_year, :category, :created_at, :updated_at
json.url book_url(book, format: :json)

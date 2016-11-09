class Book < ApplicationRecord
  def poster
    "#{poster_url}"
  end
end

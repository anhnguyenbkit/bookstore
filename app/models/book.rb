class Book < ApplicationRecord
  def poster
    "#{poster_url}"
  end

  def cart_action(current_user_id)
    if $redis.sismember "cart#{current_user_id}", id
      "Remove from"
    else
      "Add to"
    end
  end
  
  def self.search(search)
    where("name LIKE ?", "%#{search}%")
  end
end

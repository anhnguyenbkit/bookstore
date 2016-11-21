class Book < ApplicationRecord
  has_attached_file :image, styles: {small: "64x64", med: "100x100", large: "200x200" }, default_url: "/images/:style/missing.png"
  validates_attachment :image, :presence => true,
    :content_type => { :content_type => ["image/jpg", "image/jpeg", "image/png"] },
    :size => { :in => 0..100.kilobytes }
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
  
  def self.search(search) where("name LIKE ?", "%#{search}%") 
  end
end

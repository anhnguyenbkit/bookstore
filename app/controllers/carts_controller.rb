class CartsController < ApplicationController
  before_action :authenticate_user!

  def show
    cart_ids = $redis.smembers current_user_cart
    @cart_books = Book.find(cart_ids)
  end

  def add
    $redis.sadd current_user_cart, params[:book_id]
    render json: current_user.cart_count, status: 200
  end

  def remove
    $redis.srm current_user_cart, params[:book_id]
    render json: current_user.cart_count, status: 200
  end

  def sum_fee
    fees = 0.0
    Book.all.each |book| do
      fees += book.price
    end
    return fees 
  end

  private

  def current_user_cart
    "cart#{current_user.id}"
  end
end

class CartsController < ApplicationController
  before_action :authenticate_user!

  def show
    cart_ids = $redis.smembers current_user_cart
    @cart_books = Book.find(cart_ids)
  end

  def add
    logger.debug("-----> add here")
    $redis.sadd current_user_cart, params[:book_id]
    render json: current_user.cart_count, status: 200
  end

  def remove
    logger.debug("-----> remove here")
    $redis.srem current_user_cart, params[:book_id]
    render json: current_user.cart_count, status: 200
  end

  def sum_fee
    fees = 0.0
    @cart_books.each do |book|
      fees += book.price
    end
    return fees
  end
  helper_method :sum_fee

  private

  def current_user_cart
    "cart#{current_user.id}"
  end
end

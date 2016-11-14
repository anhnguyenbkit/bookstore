class CartsController < ApplicationController
  before_action :authenticate_user!
  #after_filter :sum_fee
  def show
    cart_ids = $redis.smembers current_user_cart
    @cart_books = Book.find(cart_ids)
  end

  def add
    logger.debug("-----> add here")
    $redis.sadd current_user_cart, params[:book_id]
    render json: {cart: current_user.cart_count, fee: sum_fee}, status: 200
  end

  def remove
    logger.debug("-----> remove here")
    $redis.srem current_user_cart, params[:book_id]
    render json: {cart: current_user.cart_count, fee: sum_fee}, status: 200

    #redirect_to :back
  end

  def sum_fee
    fees = 0.0
  
    @cart_books.each do |book|
      fees += book.price
    end
    puts "----> #{fees}"
    return fees
  end
  helper_method :sum_fee

  def sum_fee_json
    fee_json = sum_fee
    render json: fee_json, status: 200
  end

  private

  def current_user_cart
    "cart#{current_user.id}"
  end
end

class Users::SessionsController < Devise::SessionsController
# before_action :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
  def new
      puts "---------------> debug"
      #super
      
      if is_guest_user?
        destroy
      end
  end

  # POST /resource/sign_in
  def create
    #super
    puts "---------------> debug"
    current_or_guest_user
  end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
end

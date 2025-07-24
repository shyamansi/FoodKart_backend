
class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  # No CSRF skip needed for API-only controllers

  def google_oauth2

    auth = request.env['omniauth.auth']
     Rails.logger.error "shyammmmmmmmmmmmmmmmmm #{auth.inspect}"
    if auth.nil?
      Rails.logger.error "Omniauth auth hash is nil!"
      render json: { error: "Google authentication failed. No data received." }, status: :unauthorized and return
    end

    @user = User.from_omniauth(auth)
    if @user&.persisted?
      sign_in_and_redirect @user, event: :authentication
      set_flash_message(:notice, :success, kind: 'Google') if is_navigational_format?
    else
      session['devise.google_data'] = auth.except('extra') if auth
      redirect_to new_user_registration_url, alert: @user&.errors&.full_messages&.join("\n") || "Google authentication failed."
    end
  end
  # You should configure your model like this:
  # devise :omniauthable, omniauth_providers: [:twitter]

  # You should also create an action method in this controller like this:
  # def twitter
  # end

  # More info at:
  # https://github.com/heartcombo/devise#omniauth

  # GET|POST /resource/auth/twitter
  # def passthru
  #   super
  # end

  # GET|POST /users/auth/twitter/callback
  # def failure
  #   super
  # end

  # protected

  # The path used when OmniAuth fails
  # def after_omniauth_failure_path_for(scope)
  #   super(scope)
  # end
end

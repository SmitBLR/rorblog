class Users::OmniauthCallbacksController < ApplicationController
  def facebook
    store_location request.referer
    # You need to implement the method below in your model
    @user = User.find_for_facebook_oauth(env["omniauth.auth"], current_user)

    if @user.persisted?
      flash[:notice] = I18n.t "devise.omniauth_callbacks.success", :kind => "Facebook"
      sign_in_and_redirect @user, :event => :authentication
    else
      session["devise.facebook_data"] = env["omniauth.auth"]
      redirect_to new_user_registration_url
    end
  end

  def twitter
    store_location request.referer
    # You need to implement the method below in your model
    @user = User.find_for_twitter_oauth(env["omniauth.auth"], current_user)

    if @user.persisted?
      flash[:notice] = I18n.t "devise.omniauth_callbacks.success", :kind => "twitter"
      sign_in_and_redirect @user, :event => :authentication
    else
      session["devise.twitter_data"] = env["omniauth.auth"]
      redirect_to new_user_registration_url
    end
  end

  def passthru
    render :file => File.join(Rails.root, 'public', '404.html'), :status => 404, :layout => false
  end
end

class ApplicationController < ActionController::Base
  include ApplicationHelper

  rescue_from CanCan::AccessDenied do |e|
    if current_admin or current_user
      respond_to do |format|
        format.html { render :file => "#{Rails.root}/public/403.html", :status => :forbidden }
        format.js   { render :text => e.message, :status => :forbidden }
      end
    else
      respond_to do |format|
        format.html { redirect_to new_admin_session_path }
        format.js   { render :js => "window.location='#{ new_admin_session_path }'" }
      end

    end
  end

  def after_sign_in_path_for(resource_or_scope)
    case resource_or_scope
      when :user, User, :admin, Admin
        get_stored_location
      else
        super
    end
  end

  def after_sign_out_path_for(resource_or_scope)
    case resource_or_scope
      when :user, User, :admin, Admin
        request.referer
      else
        super
    end
  end

  def current_ability
    @current_ability ||= ::Ability.new(current_admin || current_user)
  end
end

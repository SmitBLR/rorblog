module ApplicationHelper
  private
  def store_location(path = nil)
    if path && path !~ %r{auth/\w+/callback}
      session[:return_to] = path || request.fullpath
    end
  end

  def get_stored_location
    stored_location = session[:return_to]
    clear_stored_location
    (stored_location || root_path).to_s
  end

  def clear_stored_location
    session[:return_to] = nil
  end
end

class Admins::SessionsController < Devise::SessionsController
  def new
    store_location(request.referer) if request.referer
    super
  end
end

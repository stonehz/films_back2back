class ApplicationController < ActionController::Base
  protect_from_forgery
  has_mobile_fu
  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_path, :alert => exception.message
  end

end

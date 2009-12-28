# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details
  session :session_key=>"_depot_session_id"
# before_filter :require_login
#  before_filter :require_admin
  # Scrub sensitive parameters from your log
   filter_parameter_logging :password
  def find_car
    session[:car]||=Car.new
  end

  def redirect_to_index(message)
     flash[:notice]=message
     redirect_to :controller=>"store",:action=>"index"
  end

  def require_login
    unless User.find_by_id(session[:user_id])
      session[:original_uri]=request.request_uri
      flash[:notice]="PLEASE LOGIN"
      redirect_to new_session_path
    end
  end

  def require_admin
    unless session[:admin?]
      flash[:notice]="you are not a admin!"
      redirect_to new_session_path
    end
  end
end

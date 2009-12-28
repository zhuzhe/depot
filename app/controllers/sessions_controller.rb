class SessionsController < ApplicationController
  skip_before_filter :require_login
   skip_before_filter :require_admin
  def new

  end

  def create
      session[:user_id]=nil
      session[:admin?]=nil
    if request.post?
      user =User.authenticate(params[:name],params[:password])
      if user
        session[:user_id]=user.id
        session[:admin?]=user.admin?
        uri=session[:original_uri]
        redirect_to(:controller=>"store",:action=>"index")
      else
        flash[:notice]="IVALIDE USER/PASSWORD COMBINATION"
        redirect_to new_session_path
      end
    end
  end

  def destroy
      session[:user_id]=nil
      session[:admin?]=nil
      flash[:notiec]="you already log out"
      redirect_to new_session_path
  end

end

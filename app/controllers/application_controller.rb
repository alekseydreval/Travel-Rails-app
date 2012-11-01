class ApplicationController < ActionController::Base
  protect_from_forgery
  
  helper_method :current_user, :redirect_to_login, :check_user_identity, :back_path
  
  # private
  
  def current_user
  	@current_user ||= User.find_by_id(session[:user_id]) if session[:user_id]
  end
  
  def redirect_to_login
  	unless current_user
	  	redirect_to back_path 
	end
  end

  def check_user_identity _model
  	if _model.find(params[:id]).user != current_user
  	  flash.alert = "You are not allowed for this action"
      redirect_to back_path
    end
  end

  def back_path
  	request.env["HTTP_REFERER"] || "/"
  end


end

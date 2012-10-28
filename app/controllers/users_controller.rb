class UsersController < ApplicationController
  def new
    unless current_user 
      @user = User.new
    else
      redirect_to root_url
    end
  end

  def show
    @user = User.find(params[:id])
  end
  
  def create
    @user = User.new(params[:user])
    if @user.save
      session[:user_id] = @user.id
      redirect_to root_url, :notice => "You have been successfully registered!"
    else
      flash.now[:alert] = @user.errors.full_messages
      render "new"
    end
  end
end

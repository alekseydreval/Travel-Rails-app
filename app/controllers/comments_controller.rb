class CommentsController < ApplicationController
 before_filter :redirect_to_login,  only: ['edit', 'update', 'destroy', 'create']
 before_filter(only: ['edit', 'update', 'destroy']) {|c| c.check_user_identity(Comment)}  

  def new
  end

  def create
    @comment = current_user.comments.create(params[:comment])

  	respond_to do |wants|
  		wants.html { redirect_to back_path }
  		wants.json { render json: @comment.to_json  }
  	end
  end

  def destroy
  	Comment.find(params[:id]).destroy
  	respond_to do |f|
  		f.json { render json: {status: 'ok'} }
      f.html { picture_path(@c.picture) }
  	end
  end
end

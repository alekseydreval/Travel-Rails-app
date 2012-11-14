class MessagesController < ApplicationController
	def create
		if params[:message][:chatbox_id]
			@chatbox = Chatbox.find(params[:message][:chatbox_id])
			if @chatbox.messages.create(params[:message])
				redirect_to @chatbox
			end
	    else
	    	from_user = User.find(params[:message][:user_id])
	    	to_user   = User.find(params[:message][:to_user_id])

	    	params[:message].except! :to_user_id

	    	from_user.find_or_create_chatbox(to_user).messages.create(params[:message])
	    	redirect_to to_user
	    end
	end
end

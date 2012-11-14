class ChatboxesController < ApplicationController
	def index
		@chats = current_user.chatboxes
	end

	def show
		@messages = Chatbox.find(params[:id]).messages
	end

end

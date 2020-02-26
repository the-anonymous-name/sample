class MessageController < ApplicationController
  def create
    Message.create({message: params[:message], status: false, conversation_id: params[:conversation], sender: current_user.username})
    redirect_to conversation_path params[:conversation]
  end
end

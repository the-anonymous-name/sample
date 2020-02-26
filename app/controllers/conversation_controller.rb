class ConversationController < ApplicationController
  def create
    user = User.where("username = ?", params[:receiver]).first
    if user.eql?current_user
       flash[:errors] = "Username is YOURS"
       redirect_to user_path current_user
    elsif user.present?
      if Conversation.between(current_user.id,user.id).present?
        @conversation = Conversation.between(current_user.id,user.id).first
      else
        params.permit(:sender_id, :receiver_id)
        @conversation = Conversation.create({sender_id: current_user.id, receiver_id: user.id})
      end
      redirect_to conversation_path @conversation.id
    else
      flash[:errors] = "Username is WRONG"
      redirect_to user_path current_user
    end
  end

  def show
    @conversation = Conversation.find(params[:id])
  end

  def destroy
    Conversation.find(params[:id]).destroy
    flash[:errors] = "*DELETED*"
    redirect_to user_path current_user
  end
end

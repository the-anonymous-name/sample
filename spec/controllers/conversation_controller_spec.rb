require 'rails_helper'

RSpec.describe ConversationController, type: :controller do
  describe 'create' do
    it 'should create conversation' do
      user = User.create(:username => "abc123", :password => "abc123abc123", :email => "abc@123.com", :phone => "9898989898")
      user1 = User.create(:username => "123abc", :password => "123abc123abc", :email => "123@abc.com", :phone => "8989898989")
      session[:current_user_id] = user.id
      post :create, {:receiver => user1.username}
      conversation = Conversation.last
      User.destroy_all
      expect(response).to redirect_to("/conversation/#{conversation.id}")
      Conversation.destroy_all
    end

    it 'should not create own conversation' do
      user = User.create(:username => "abc123", :password => "abc123abc123", :email => "abc@123.com", :phone => "9898989898")
      session[:current_user_id] = user.id
      post :create, {:receiver => user.username}
      User.destroy_all
      expect(response).to redirect_to("/user/#{user.id}")
      Conversation.destroy_all
    end

    it 'should not create duplicate conversation' do
      user = User.create(:username => "abc123", :password => "abc123abc123", :email => "abc@123.com", :phone => "9898989898")
      session[:current_user_id] = user.id
      user1 = User.create(:username => "123abc", :password => "123abc123abc", :email => "123@abc.com", :phone => "8989898989")
      conversation1 = Conversation.create(:sender_id => user1.id, :receiver_id => user.id)
      post :create, {:receiver => user1.username}
      conversation = Conversation.last
      User.destroy_all
      expect(response).to redirect_to("/conversation/#{conversation.id}")
      Conversation.destroy_all
    end

    it 'should not create wrong conversation' do
      user = User.create(:username => "abc123", :password => "abc123abc123", :email => "abc@123.com", :phone => "9898989898")
      session[:current_user_id] = user.id
      post :create, {:receiver => "123abc"}
      User.destroy_all
      expect(response).to redirect_to("/user/#{user.id}")
      Conversation.destroy_all
    end
  end

  describe 'GET#show' do
    it 'should show conversation' do
   			user = User.create(:username => "abc123", :password => "abc123abc123", :email => "abc@123.com", :phone => "9898989898")
        user1 = User.create(:username => "123abc", :password => "123abc123abc", :email => "123@abc.com", :phone => "8989898989")
        conversation = Conversation.create(:sender_id => user.id, :receiver_id => user1.id)
        session[:current_user_id] = user.id
        get :show, {id: conversation.id}
	   		User.destroy_all
        assigns(:conversation).should == conversation
        Conversation.destroy_all
   		end
  end

  describe 'delete' do
    it 'should delete conversation' do
      user = User.create(:username => "abc123", :password => "abc123abc123", :email => "abc@123.com", :phone => "9898989898")
      user1 = User.create(:username => "123abc", :password => "123abc123abc", :email => "123@abc.com", :phone => "8989898989")
      conversation = Conversation.create(:sender_id => user.id, :receiver_id => user1.id)
      session[:current_user_id] = user.id
      delete :destroy, {id: conversation.id}
      User.destroy_all
      expect(response).to redirect_to("/user/#{user.id}")
      Conversation.destroy_all
    end
  end
end

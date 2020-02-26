require 'rails_helper'

RSpec.describe UserController, type: :controller do
  describe 'GET#new' do
		it 'new' do
			get :new
			response.should render_template :new
		end
	end

  describe 'create' do
    it 'should create user' do
      post :create, {:user => {:username => "abc123", :password => "abc123abc123", :email => "abc@123.com", :phone => "9898989898"}}
      user = User.find_by(username: "abc123")
      expect(response).to redirect_to("/user/#{user.id}")
      User.destroy_all
    end

    it 'should not create user which is empty' do
      post :create, {:user => {:username => "", :password => "", :email => "", :phone => ""}}
      expect(response).to render_template :new
      User.destroy_all
    end

    it 'should not create duplicate user' do
      User.create(:username => "abc123", :password => "abc123abc123", :email => "abc@123.com", :phone => "9898989898")
      post :create, {:user => {:username => "abc123", :password => "abc123abc123", :email => "abc@123.com", :phone => "9898989898"}}
      expect(response).to render_template :new
      User.destroy_all
    end

    it 'should not create user which is wrong' do
      post :create, {:user => {:username => "abc", :password => "abcabc", :email => "abc@abc.com", :phone => "98989"}}
      expect(response).to render_template :new
      User.destroy_all
    end
  end

  describe 'GET#show' do
    it 'show' do
   			user = User.create(:username => "abc123", :password => "abc123abc123", :email => "abc@123.com", :phone => "9898989898")
        session[:current_user_id] = user.id
        get :show, {id: user.id}
	   		assigns(:user).should == user
	   		User.destroy_all
   		end
  end
end

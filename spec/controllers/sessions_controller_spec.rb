# frozen_string_literal: true

# spec/controllers/sessions_controller_spec.rb
require 'rails_helper'

RSpec.describe SessionsController, type: :controller do
  let(:user) { create(:user) }

  describe 'GET #new' do
    it 'returns a success response' do
      get :new
      expect(response).to be_successful
    end
  end

  describe 'POST #create' do
    context 'with valid credentials' do
      it 'logs in the user' do
        post :create, params: { username: user.username, password: user.password }
        expect(session[:user_id]).to eq(user.id)
      end

      it 'redirects to the user' do
        post :create, params: { username: user.username, password: user.password }
        expect(response).to redirect_to(user)
      end
    end

    context 'with invalid credentials' do
      it 'does not log in the user' do
        post :create, params: { username: user.username, password: 'wrong password' }
        expect(session[:user_id]).to be_nil
      end

      it 'redirects to the login page' do
        post :create, params: { username: user.username, password: 'wrong password' }
        expect(response).to redirect_to(login_path)
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'logs out the user' do
      delete :destroy
      expect(session[:user_id]).to be_nil
    end

    it 'redirects to the login page' do
      delete :destroy
      expect(response).to redirect_to(login_path)
    end
  end
end

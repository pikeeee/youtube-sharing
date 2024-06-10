# frozen_string_literal: true

require 'rails_helper'

RSpec.describe VideosController, type: :controller do
  let(:user) { create(:user) }
  let(:video) { create(:video, user:) }

  describe 'GET #index' do
    it 'assigns all videos to @videos' do
      video = create(:video, user:)
      get :index
      expect(assigns(:videos)).to eq([video])
    end
  end

  describe 'POST #create' do
    context 'with valid params' do
      it 'creates a new Video' do
        sign_in user
        expect do
          post :create, params: { video: attributes_for(:video) }
        end.to change(Video, :count).by(1)
      end
    end

    it 'does not save the new video' do
      sign_in user
      expect do
        post :create, params: { video: attributes_for(:video, url: 'https://www.youtube.com/watch?v=dQw4w9WgXc1') }
      end.to_not change(Video, :count)
    end
  end

  describe 'PUT #update' do
    context 'with valid params' do
      it 'updates the requested video' do
        sign_in user
        put :update, params: { id: video.id, video: attributes_for(:video, url: 'https://www.youtube.com/watch?v=dQw4w9WgXcQ') }
        video.reload
        expect(video.url).to eq('https://www.youtube.com/watch?v=dQw4w9WgXcQ')
      end
    end

    context 'with invalid params' do
      it 'does not update the video' do
        sign_in user
        put :update, params: { id: video.id, video: attributes_for(:video, url: 'https://www.youtube.com/watch?v=dQw4w9WgXc1') }
        video.reload
        expect(video.url).to_not be_nil
      end
    end
  end
end

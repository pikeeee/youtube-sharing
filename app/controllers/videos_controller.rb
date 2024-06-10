# frozen_string_literal: true

class VideosController < ApplicationController
  before_action :authorized, only: %i[new create edit update]
  before_action :find_video, only: %i[edit update]

  def index
    @videos = Video.all
    video_ids = @videos.map(&:extract_video_id).compact

    return unless video_ids.any?

    begin
      response = YoutubeService.list_videos('snippet', id: video_ids.join(','))
      @video_details = response.items
    rescue Google::Apis::ClientError => e
      Rails.logger.error e.message
    end
  end

  def new
    @video = Video.new
  end

  def edit; end

  def update
    if @video.update(video_params)
      redirect_to root_path, notice: 'Video updated successfully!'
    else
      render :edit
    end
  end

  def create
    @video = current_user.videos.build(video_params)
    if @video.save
      redirect_to root_path, notice: 'Video added successfully!'
    else
      render :new
    end
  end

  private

  def find_video
    @video = Video.find_by(id: params[:id])
  end

  def video_params
    params.require(:video).permit(:url)
  end
end

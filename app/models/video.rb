# frozen_string_literal: true

# == Schema Information
#
# Table name: videos
#
#  id         :bigint           not null, primary key
#  title      :string
#  url        :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :integer          not null
#
# Indexes
#
#  index_videos_on_user_id  (user_id)
#
class Video < ApplicationRecord
  belongs_to :user
  after_create :broadcast_video
  validate :video_exists_on_youtube

  def extract_video_id
    url.match(%r{youtu(?:\.be|be\.com)/(?:watch\?v=)?([\w-]{11})})&.[](1)
  end

  private

  def broadcast_video
    ActionCable.server.broadcast('videos_channel', rendered_video)
  end

  def rendered_video
    title = YoutubeService.list_videos('snippet', id: extract_video_id).items.first.snippet.title
    update(title:) if title
    ApplicationController.renderer.render(
      partial: 'videos/video',
      locals: { video: self }
    )
  end

  def video_exists_on_youtube
    video = YoutubeService.list_videos('snippet', id: extract_video_id).items.first
    return unless video.nil?

    errors.add(:url, 'does not exist on YouTube')
  end
end

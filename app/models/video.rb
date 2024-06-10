# frozen_string_literal: true

# == Schema Information
#
# Table name: videos
#
#  id         :bigint           not null, primary key
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

  def extract_video_id
    url.match(%r{youtu(?:\.be|be\.com)/(?:watch\?v=)?([\w-]{11})})&.[](1)
  end
end

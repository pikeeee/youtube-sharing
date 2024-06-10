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
FactoryBot.define do
  factory :video do
    url { 'https://www.youtube.com/watch?v=dQw4w9WgXcQ' }
    title { 'Rick Astley - Never Gonna Give You Up' }
    user
  end
end

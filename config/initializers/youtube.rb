
require 'google/apis/youtube_v3'

YOUTUBE_API_KEY = ENV['YOUTUBE_API_KEY']

YoutubeService = Google::Apis::YoutubeV3::YouTubeService.new
YoutubeService.key = YOUTUBE_API_KEY

# frozen_string_literal: true

class VideosChannel < ApplicationCable::Channel
  def subscribed
    # stream_from "some_channel"
    stream_from 'videos_channel'
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def receive(data)
    ActionCable.server.broadcast('videos_channel', data)
  end
end

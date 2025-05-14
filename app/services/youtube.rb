require 'google/apis/youtube_v3'

class Youtube
  def initialize(keyword: nil, max_results: nil, channel_id: nil)
    @youtube = Google::Apis::YoutubeV3::YouTubeService.new
    @youtube.key = ENV['YOUTUBE_API_KEY']
    @keyword = keyword
    @max_results = max_results
    @channel_id = channel_id
  end

  def search_by_keyword
    res = find_video_by_keyword
    res.to_json
  end

  def fetch_channel_info
    res = find_channel_info
    res.to_json
  end

  private

  # キーワードからYoutubeの動画を検索し、結果を返す
  def find_video_by_keyword
    opt = {
      q: @keyword,
      type: 'video',
      max_results: @max_results,
      page_token: nil
    }
    @youtube.list_searches('snippet', **opt)
  end

  def find_channel_info
    @youtube.list_channels('snippet', id: @channel_id)
  end
end

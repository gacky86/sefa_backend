require 'google/apis/youtube_v3'

class Youtube
  def initialize(keyword:, max_results:)
    @youtube = Google::Apis::YoutubeV3::YouTubeService.new
    @youtube.key = ENV['YOUTUBE_API_KEY']
    @keyword = keyword
    @max_results = max_results
  end

  def run
    res = find_video_by_keyword
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
end

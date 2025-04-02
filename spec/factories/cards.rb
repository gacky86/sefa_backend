FactoryBot.define do
  factory :card do
    input_proficiency { 1 }
    output_proficiency { 1 }
    english { "MyString" }
    japanese { "MyString" }
    source_video_url { "MyString" }
    reviewed_date { "2025-04-02" }
    source_video_timestamp { "MyString" }
  end
end

class Card < ApplicationRecord
  # Association
  belongs_to :flashcard
  has_one :learning_factor, dependent: :destroy

  # Validation
  validates :japanese, :english, length: { maximum: 255 }, presence: true

  # methods
  def calc_review_intervals(mode:)
    current_interval = learning_factor.send("#{mode}_interval")
    ease_factor = learning_factor.send("#{mode}_ease_factor")

    threshold = 60
    easy_bonus = 1.3
    again_interval = 1

    hard_interval = if current_interval.zero?
                      6
                    else
                      (current_interval * 1.2).round(0)
                    end

    good_interval = if current_interval.zero?
                      10
                    else
                      (current_interval * ease_factor.to_f / 100).round(0)
                    end

    easy_interval = if current_interval.zero?
                      3 * threshold
                    else
                      (current_interval * ease_factor.to_f / 100 * easy_bonus).round(0)
                    end

    intervals = [again_interval, hard_interval, good_interval, easy_interval]

    intervals.map do |interval|
      if interval < 60
        "<#{interval}m"
      else
        "#{(interval.to_f / 60).round(0)}d"
      end
    end
  end
end

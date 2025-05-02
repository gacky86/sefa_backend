class Flashcard < ApplicationRecord
  # Association
  belongs_to :user
  has_many :cards, dependent: :destroy
  has_many :learning_factors, through: :cards

  # Validation
  validates :title, length: { maximum: 60 }
  validates :description, length: { maximum: 120 }
  validates :input_target, :output_target, presence: true
  validates :title, presence: true, uniqueness: { scope: :user_id }

  # methods
  def select_card_by_interval(mode:)
    if mode == 'input'
      cards = self.cards
      minimum_interval = learning_factors.minimum(:input_interval)
      # 日換算したintervalが前回学習日~本日の期間よりも長い場合、本日学習するべきcardから除外する
      todays_cards = cards.reject do |card|
        if card.learning_factor.input_interval >= 60
          interval_day = (card.learning_factor.input_interval / 60.0).ceil
          interval_day > Time.zone.today - card.learning_factor.input_learned_at
        end
      end
      # 本日学習分のcardsの中で、最もintervalが短いcardを選ぶ。ただし、同じintervalのcardがある場合を考慮して、ランダムに一枚選ぶ。
      top_cards = todays_cards.select do |card|
        card.learning_factor.input_interval == minimum_interval
      end
      top_card = top_cards.sample
    elsif mode == 'output'
      cards = self.cards
      minimum_interval = learning_factors.minimum(:output_interval)
      # 日換算したintervalが前回学習日~本日の期間よりも長い場合、本日学習するべきcardから除外する
      todays_cards = cards.reject do |card|
        if card.learning_factor.output_interval >= 60
          interval_day = (card.learning_factor.output_interval / 60.0).ceil
          interval_day > Time.zone.today - card.learning_factor.output_learned_at
        end
      end
      # 本日学習分のcardsの中で、最もintervalが短いcardを選ぶ。ただし、同じintervalのcardがある場合を考慮して、ランダムに一枚選ぶ。
      top_cards = todays_cards.select do |card|
        card.learning_factor.output_interval == minimum_interval
      end
      top_card = top_cards.sample
    end
    top_card
  end
end

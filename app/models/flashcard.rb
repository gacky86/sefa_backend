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
  def select_card_by_interval(mode:, last_card_id:)
    interval_attr = "#{mode}_interval"
    learned_at_attr = "#{mode}_learned_at"

    cards = self.cards
    minimum_interval = learning_factors.minimum(interval_attr.to_sym)
    # 日換算したintervalが前回学習日~本日の期間よりも長い場合、本日学習するべきcardから除外する
    todays_cards = cards.reject do |card|
      interval = card.learning_factor.send(interval_attr)
      learned_at = card.learning_factor.send(learned_at_attr)
      if interval >= 60
        interval_day = (interval / 60.0).ceil
        interval_day > Time.zone.today - learned_at
      else
        false
      end
    end
    # 本日学習分のcardsの中で、最もintervalが短いcardを選ぶ。ただし、同じintervalのcardがある場合を考慮して、ランダムに一枚選ぶ。
    top_cards = todays_cards.select do |card|
      card.learning_factor.send(interval_attr) == minimum_interval
    end
    card_to_learn = top_cards.sample

    # 学習カードが一枚もない場合は何も返さない
    return unless card_to_learn

    # 学習カードが前回のカードと重複しない場合はそのままカードを返す(frontendからのlast_card_idはstrになっているので変換)
    return card_to_learn unless card_to_learn.id == last_card_id.to_i

    # last_cardと選んだカードが一致する場合は、top_cardsの長さが1の場合は何も返さない(<=本日学習分のカードが一枚だけになっている状況なので)
    if top_cards.length == 1
      nil
    # top_cardsの長さが1よりも大きい場合は、選び直しを行う
    elsif top_cards.length > 1
      top_cards.sample
    end
  end
end

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

    # 日換算したintervalが前回学習日~本日の期間よりも長い場合、本日学習するべきcardから除外する
    todays_cards = select_todays_cards(interval_attr: interval_attr, learned_at_attr: learned_at_attr)

    # 本日学習分のcardsの中で、最もintervalが短いcardを選ぶ。ただし、同じintervalのcardがある場合を考慮して、ランダムに一枚選ぶ。
    minimum_interval = learning_factors.minimum(interval_attr.to_sym)
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

  def select_todays_cards(interval_attr:, learned_at_attr:)
    cards = self.cards
    cards.reject do |card|
      interval = card.learning_factor.send(interval_attr)
      learned_at = card.learning_factor.send(learned_at_attr)
      if interval >= 60
        interval_day = (interval / 60.0).ceil
        interval_day > Time.zone.today - learned_at
      else
        false
      end
    end
  end

  def count_todays_cards
    # 日換算したintervalが前回学習日~本日の期間よりも長い場合、本日学習するべきcardから除外する
    todays_input_cards = select_todays_cards(interval_attr: 'input_interval', learned_at_attr: 'input_learned_at')
    todays_output_cards = select_todays_cards(interval_attr: 'output_interval', learned_at_attr: 'output_learned_at')

    new_input_cards = todays_input_cards.map do |card|
      card.learning_factor.send('input_interval').zero?
    end
    new_output_cards = todays_output_cards.map do |card|
      card.learning_factor.send('output_interval').zero?
    end

    # new_cardの枚数, review_cardの枚数
    [new_input_cards.length, todays_input_cards.length - new_input_cards.length,
     new_output_cards.length, todays_output_cards.length - new_output_cards.length]
  end
end

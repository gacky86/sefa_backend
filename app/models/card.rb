class Card < ApplicationRecord
  # Association
  belongs_to :flashcard
  has_one :learning_factor, dependent: :destroy

  # Validation
  validates :japanese, :english, length: { maximum: 255 }, presence: true
end

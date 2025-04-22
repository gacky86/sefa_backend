class Card < ApplicationRecord
  # Association
  belongs_to :flashcard

  # Validation
  validates :japanese, :english, length: { maximum: 255 }, presence: true
end

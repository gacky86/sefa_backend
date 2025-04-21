class Card < ApplicationRecord
  # Association
  belongs_to :flashcard

  # Validation
  # japanese 255
  validates :japanese, length: { maximum: 255 }
  # english 255
  validates :english, length: { maximum: 255 }
end

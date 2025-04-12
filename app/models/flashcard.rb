class Flashcard < ApplicationRecord
  # Association
  belongs_to :user
  has_many :cards, dependent: :destroy
  # Validation
end

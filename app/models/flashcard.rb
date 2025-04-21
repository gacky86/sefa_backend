class Flashcard < ApplicationRecord
  # Association
  belongs_to :user
  has_many :cards, dependent: :destroy
  # Validation
  # title
  validates :title, length: { maximum: 60 }
  # description
  validates :description, length: { maximum: 120 }
end

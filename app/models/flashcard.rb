class Flashcard < ApplicationRecord
  # Association
  belongs_to :user
  has_many :cards, dependent: :destroy

  # Validation
  validates :title, length: { maximum: 60 }
  validates :description, length: { maximum: 120 }
  validates :title, :input_target, :output_target, presence: true
end

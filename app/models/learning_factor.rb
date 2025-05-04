class LearningFactor < ApplicationRecord
  # associations
  belongs_to :card

  # validations
  # validates :input_step, :input_ease_factor, :output_step, :output_ease_factor, presence: true

  # methods
  def update_by(difficulty:, mode:)
    easy_bonus = 1.3
    threshold = 60
    max_interval = 60 * 30
    ease_attr = "#{mode}_ease_factor"
    interval_attr = "#{mode}_interval"

    ease_factor = send(ease_attr)
    interval = send(interval_attr)

    case difficulty
    when 'Again'
      send("#{ease_attr}=", [ease_factor - 20, 130].max)
      send("#{interval_attr}=", 1)
    when 'Hard'
      send("#{ease_attr}=", [ease_factor - 15, 130].max)
      if interval.zero?
        send("#{interval_attr}=", 6.0)
      else
        send("#{interval_attr}=", [interval * 1.2, max_interval].min)
      end
    when 'Good'
      if interval.zero?
        send("#{interval_attr}=", 10.0)
      else
        send("#{interval_attr}=", [interval * ease_factor.to_f / 100, max_interval].min)
      end
    when 'Easy'
      send("#{ease_attr}=", ease_factor + 15)
      if interval.zero?
        send("#{interval_attr}=", 3 * threshold)
      else
        send("#{interval_attr}=", [interval * ease_factor.to_f / 100 * easy_bonus, max_interval].min)
      end
    end
    save!
  end
end

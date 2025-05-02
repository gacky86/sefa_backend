FactoryBot.define do
  factory :learning_factor do
    input_step { 1 }
    input_ease_factor { 1.5 }
    input_interval { 1.5 }
    output_step { 1 }
    output_ease_factor { 1.5 }
    output_interval { 1.5 }
    input_learned_at { "2025-04-27" }
    output_learned_at { "2025-04-27" }
  end
end

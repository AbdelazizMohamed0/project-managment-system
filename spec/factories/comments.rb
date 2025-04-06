FactoryBot.define do
  factory :comment do
    content { Faker::Lorem.paragraph }
    association :project
    association :user
  end
end 
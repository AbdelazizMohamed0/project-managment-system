FactoryBot.define do
  factory :project do
    association :user
    name { Faker::Company.catch_phrase }
    description { Faker::Lorem.paragraph }
    current_status { 'Not Started' }
    
    trait :not_started do
      current_status { 'Not Started' }
    end
    
    trait :in_progress do
      current_status { 'In Progress' }
    end
    
    trait :on_hold do
      current_status { 'On Hold' }
    end
    
    trait :completed do
      current_status { 'Completed' }
    end
  end
end 
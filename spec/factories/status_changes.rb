FactoryBot.define do
  factory :status_change do
    association :project
    association :user
    from_status { 'Not Started' }
    to_status { 'In Progress' }
  end
end 
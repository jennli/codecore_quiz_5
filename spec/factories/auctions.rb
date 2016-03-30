FactoryGirl.define do
  factory :auction do
    association :user, factory: :user
    sequence(:title)        {|n| "#{Faker::Company.bs}-#{n}"}
    sequence(:details) {|n| "#{Faker::Lorem.paragraph}-#{n}"}
    price        2000
    end_date    60.days.from_now
  end
end

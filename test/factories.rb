FactoryGirl.define do

	factory :user do
    sequence(:username) { |n| "abcde#{n}"}
    sequence(:email) { |n| "valid_email#{n}@email.com"}
    sequence(:password) { |n| "passw#{n}rd"}
  end

  factory :league do
  	sequence(:name) { |n| "league#{n}" }
  end

  factory :match do
  end
end

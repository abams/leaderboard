FactoryGirl.define do

	factory :user, :aliases => [:winner, :loser] do
    sequence(:username) { |n| "abcde#{n}"}
    sequence(:email) { |n| "valid_email#{n}@email.com"}
    sequence(:password) { |n| "passw#{n}rd"}
  end

  factory :game do
    winner
    loser
  end

  factory :ranking do
    user
    score 100
  end

end

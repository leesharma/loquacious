FactoryGirl.define do
  factory :user do
    sequence :email do |n|
      "user#{n}@example.com"
    end
    sequence :username do |n|
      "username#{n}"
    end
    password 'password'
    password_confirmation 'password'
  end

  factory :chat_room do
    sequence :name do |n|
      "room#{n}"
    end
  end

  factory :message do
    user
    chat_room
    message 'hello, world'
  end
end

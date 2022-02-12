FactoryBot.define do
  factory :user do
    name { "user_name" }
    email { "user@sample.com" }
    password { "password" }
  end
  factory :second_user, class: User do
    name { "second_user_name" }
    email { "second-user@sample.com" }
    password { "password" }
  end
  factory :third_user, class: User do
    name { "third_user_name" }
    email { "third-user@sample.com" }
    password { "password" }
  end
end

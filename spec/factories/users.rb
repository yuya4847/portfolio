FactoryBot.define do
  factory :user, class: User do
    username { "yuya" }
    email  { "testyuya@example.com" }
    password { "password" }
    password_confirmation { "password" }
  end
end

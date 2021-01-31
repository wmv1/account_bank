FactoryBot.define do
  factory :user, class: User do
    username { "John" }
    password  { "12345678" }
  end
end
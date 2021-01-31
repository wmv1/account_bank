FactoryBot.define do
  factory :account, class: Account do
    association :user
    account_id { Time.now.to_i }
    account_name  { "Whiskas sache" }
    balance  { 100.0 }
  end
end
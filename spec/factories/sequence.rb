FactoryBot.define do
  sequence(:name) do |n|
    "Name_#{n}"
  end

  sequence(:email) do |n|
    "email-#{n}@example.com"
  end

  sequence(:uuid) do |n|
    SecureRandom.uuid
  end
end
FactoryBot.define do
  factory :microposts, class: Micropost do
    trait :micropost_1 do
      content { 'MyFirstText' }
      user_id { 1 }
      created_at { 10.minutes.ago }
    end

    trait :micropost_2 do
      content { 'SecondText' }
      user_id { 1 }
      created_at { 3.years.ago }
    end

    trait :micropost_3 do
      content { 'ThirdText' }
      user_id { 1 }
      created_at { 2.hours.ago }
    end

    trait :micropost_4 do
      content { 'FourthText' }
      user_id { 1 }
      created_at { Time.zone.now }
    end
  end
end

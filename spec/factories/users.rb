FactoryBot.define do
  factory :user do
    name { 'Example User' }
    email { 'user@example.com' }
    password { 'password' }
    password_confirmation { 'password' }
    admin { true }
  end

  factory :other_user, class: User do
    name { 'Second User' }
    email { 'luiji@example.com' }
    password { 'foobar' }
    password_confirmation { 'foobar' }
  end
end

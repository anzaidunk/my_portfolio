FactoryBot.define do
  factory :user do
    name { 'Example User' }
    email { 'user@example.com' }
    password { 'password' }
    password_confirmation { 'password' }
    admin { true }
    activated { true }
  end

  factory :other_user, class: User do
    name { 'Second User' }
    email { 'luiji@example.com' }
    password { 'foobar' }
    password_confirmation { 'foobar' }
    activated { true }
  end

  factory :no_activation_user, class: User do
    name { 'Third User' }
    email { 'third@example.com' }
    password { 'three3' }
    password_confirmation { 'three3' }
    activated { false }
  end
end

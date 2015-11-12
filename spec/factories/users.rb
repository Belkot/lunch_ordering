FactoryGirl.define do
  factory :user do
    name { Faker::Name.name[0...20] }
    email { Faker::Internet.email }
    password '12345678'
    factory :admin do
      admin true
    end
  end

end

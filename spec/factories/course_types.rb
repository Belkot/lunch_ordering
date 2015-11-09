FactoryGirl.define do
  factory :course_type do
    name { Faker::Lorem.word[1..20] }
  end

end

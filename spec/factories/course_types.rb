FactoryGirl.define do
  factory :course_type do
    name { Faker::Lorem.word[0...20] }
  end

end

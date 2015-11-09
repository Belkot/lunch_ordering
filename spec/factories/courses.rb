FactoryGirl.define do
  factory :course do
    name { Faker::Name.name[3..30] }
    price { Faker::Commerce.price }
    course_type
    deleted_at nil
  end

end

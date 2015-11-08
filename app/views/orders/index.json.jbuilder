json.orders @orders do |order|
  json.extract! order, :id, :created_at
  json.user order.user, :name, :email
  json.courses order.courses do |course|
    json.course_types course.course_type.name
    json.extract! course, :name, :price
  end
end
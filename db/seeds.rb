User.delete_all
Order.delete_all
LineItem.delete_all
Course.delete_all
CourseType.delete_all

CourseType.create([{ name: 'First course' }, { name: 'Main course' }, { name: 'Drink' }])

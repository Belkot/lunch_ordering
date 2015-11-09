require 'rails_helper'

feature 'As a Lunches Admin' do

  background do
    @admin = create(:user)
    @user = create(:user)
    visit root_path
    fill_in 'Email', with: @admin.email
    fill_in 'user_password', with: @admin.password
    click_button 'Log in'
  end

  scenario 'I can browse registered users' do
    click_link 'Users'
    expect(page).to have_content 'Users:'
    expect(page).to have_content @admin.name
    expect(page).to have_content @user.name
  end

  scenario 'I can browse days and see users orders there' do
    click_link 'Orders'
    expect(page).to have_content 'Listing orders:'
  end

  scenario 'I can add items in menu only for today by adding a name and price' do
    course_type = create(:course_type)
    click_link 'Menu'
    click_link 'New Course'
    expect{
      fill_in 'Name', with: 'Some course'
      fill_in 'Price', with: 15.3
      select course_type.name, from: 'Course type'
      click_button 'Create Course'
      }.to change(Course, :count).by(1)
    expect(Course.for_date(Date.today - 1.day).count).to eq 0
  end

  scenario 'on the date page I can see the list of orders and total launch cost for today' do
    course1 = create(:course, price: 3)
    course2 = create(:course, price: 4)
    course3 = create(:course, price: 5)
    order = @user.orders.new
    order.courses << [course1, course2, course3]
    order.save

    click_link 'Orders'
    expect(page).to have_content 'Listing orders:'
    expect(page).to have_content course1.name
    expect(page).to have_content course2.name
    expect(page).to have_content course3.name
    expect(page).to have_content '$12.00'
  end

end

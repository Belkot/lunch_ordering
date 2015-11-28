require 'rails_helper'

feature 'As s user' do

  background do
    admin = create(:user)
    @user = create(:user)
    visit root_path
    fill_in 'Email', with: @user.email
    fill_in 'user_password', with: @user.password
    click_button 'Log in'
  end

  scenario 'I can edit my profile' do
    click_link 'Profile'
    fill_in 'Name', with: 'admin_username'
    fill_in 'Current password', with: @user.password
    click_button 'Update'
    expect(page).to have_content 'Your account has been updated successfully.'
    expect(page).to have_content 'admin_username Logout'
  end

  scenario 'I can see a weekdays on the dashboard page' do
    within 'h1' do
      expect(page).to have_content 'Dashboard'
    end
    ((Date.today - 7.day)..Date.today).each do |date|
      unless date.sunday? || date.saturday?
        expect(page).to have_content date.day
      end
    end
  end

  scenario 'when I click on the weekday(today or days in the past), I can see menu ­ list of items with prices' do
    course1 = create(:course, created_at: Date.today - 5.day)
    course2 = create(:course, created_at: Date.today - 5.day)
    course3 = create(:course, created_at: Date.today - 5.day)

    date = Date.today
    date -= 3.day if date.sunday? || date.saturday?
    expect(page).to have_content date.day
    click_link date.day
    expect(page).to have_content 'Menu'
    expect(page).to have_content "#{course1.name} - $#{course1.price.round(2)}"
    expect(page).to have_content "#{course2.name} - $#{course2.price.round(2)}"
    expect(page).to have_content "#{course3.name} - $#{course3.price.round(2)}"
  end

  scenario 'I can press Submit button to process my order' do
    create(:course, name: 'First course', created_at: Date.today - 5.day)
    create(:course, name: 'Main course', created_at: Date.today - 5.day)
    create(:course, name: 'Drink course', created_at: Date.today - 5.day)

    visit new_order_path
    expect{
      choose 'First course'
      choose 'Main course'
      choose 'Drink course'
      click_button 'Submit'
    }.to change(Order, :count).by(1)
  end

end

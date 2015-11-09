require 'rails_helper'

feature 'As s guest' do

  scenario 'I should be able to sign up with name, email and password' do
    visit root_path
    click_link 'Sign up'

    expect{
      fill_in 'Name', with: 'admin_username'
      fill_in 'Email', with: 'admin@test.test'
      fill_in 'user_password', with: 'admin_password'
      fill_in 'user_password_confirmation', with: 'admin_password'
      click_button 'Sign up'
    }.to change(User, :count).by(1)
    expect(current_path).to eq root_path
    expect(page).to have_content 'Welcome! You have signed up successfully.'
    within 'h1' do
      expect(page).to have_content 'Dashboard'
    end
  end

  scenario 'I should be able to sign in with email and password' do
    user = create(:user)
    visit root_path
    fill_in 'Email', with: user.email
    fill_in 'user_password', with: user.password
    click_button 'Log in'

    expect(current_path).to eq root_path
    expect(page).to have_content 'Signed in successfully.'
    within 'h1' do
      expect(page).to have_content 'Dashboard'
    end
  end

  scenario 'As a first registered user in the system, I become a Lunches Admin' do
    user_first = create(:user)
    user_second = create(:user)

    expect(user_first.admin?).to be_truthy
    expect(user_second.admin?).to be_falsey
  end

end

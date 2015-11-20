require 'rails_helper'

feature 'As a system' do

  background do
    visit api_orders_url + '.json?key=TESTORDERAPIKEY'
  end

  scenario 'I should be able to provide list of the orders for today with details for each person through RESTful JSON API endpoint' do
    expect(page).to have_content 'orders'
  end

  scenario 'I should have a secure API' do
    expect(page.status_code).to eq 200
  end

  scenario 'I should have a secure API with wrong key' do
    visit api_orders_url + '.json?key=wrongAPIKEY'
    expect(page).to have_content 'Unauthorized, check the key'
    expect(page.status_code).to eq 401
  end

end

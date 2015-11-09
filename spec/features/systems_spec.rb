require 'rails_helper'

feature 'As a system' do

  background do
    visit orders_url + '.json?key=TESTORDERAPIKEY'
  end

  scenario 'I should be able to provide list of the orders for today with details for each person through RESTful JSON API endpoint' do
    expect(page).to have_content 'orders'
  end

  scenario 'I should have a secure API' do
    expect(page.status_code).to eq 200
  end

end

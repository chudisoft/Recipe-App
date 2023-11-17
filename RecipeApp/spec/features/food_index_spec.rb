require 'rails_helper'

RSpec.describe 'Food index', type: :feature do
  Rails.application.routes.default_url_options[:host] = 'localhost:3000'
  let(:user) { User.new(name: 'example', email: 'user@example.com', password: 'password',) }
  let(:food) { Food.new(name: 'Flour', measurement_unit: 'grams', price: 2, quantity: 10, user: user) }
  before {user.save}
  before { food.save }
  
  describe 'food index' do
    it 'shows a list of foods' do
      visit new_user_session_path
      fill_in 'Email', with: 'user@example.com'
      fill_in 'Password', with: 'password'
      click_button 'Log in'
      visit foods_path
      expect(page).to have_content('Your Foods')
      foods = user.foods.each do |food|
        expect(page).to have_content(food.name)
      end
    end
  end
end
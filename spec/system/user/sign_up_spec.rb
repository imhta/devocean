# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'User page', type: :system do
  context 'User Sign Up' do
    before(:each) do
      visit new_user_registration_path
      within 'form' do
        fill_in 'First name', with: 'First'
        fill_in 'Last name', with: 'Last'
        fill_in 'Email', with: 'test@example.com'
        select 'Men', from: 'gender-select'
        fill_in 'Dob', with: '12/11/1997'
        fill_in 'Password', with: 'test123'
        fill_in 'Password confirmation', with: 'test123'
      end
    end

    scenario 'User signs up successfully' do
      click_button 'Sign up'
      expect(page).to have_content('Welcome! You have signed up successfully.')
    end

    scenario 'User fills in incorrect information' do
      within 'form' do
        fill_in 'First name', with: ''
        click_button 'Sign up'
      end
      expect(page).to have_content("First name can't be blank")
    end
  end
end

# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'User Sign In', type: :system do
  context 'User Sign In' do
    let(:user) { FactoryBot.create(:user) }
    before(:each) do
      visit root_path
      within 'form' do
        fill_in 'Email', with: user.email
      end
    end

    scenario 'User signs in successfully' do
      within 'form' do
        fill_in 'Password', with: user.password
        click_button 'Log in'
      end
      expect(page).to have_content('Signed in successfully.')
    end

    scenario 'User fills in incorrect password' do
      within 'form' do
        fill_in 'Password', with: 'wrong password'
        click_button 'Log in'
      end
      expect(page).to have_content('Invalid Email or password.')
    end
  end
end

require 'rails_helper'

RSpec.describe 'Logging in', type: :feature do
  describe 'As a regular User' do
    it 'can login with valid credentials' do
      user_1 = create(:user, role: 0)

      visit '/'

      click_link('Login')

      expect(current_path).to eq('/login')

      fill_in :email, with: user_1.email
      fill_in :password, with: 'password1'
      click_on('Submit')

      expect(current_path).to eq('/profile')
      expect(page).to have_content("Welcome back, #{user_1.name} you are now logged in!")
      expect(page).to have_content("Hello, #{user_1.name}!")
    end

    describe "if I am already logged in and visit the login path" do
      it "I am redirected to my profile page" do
        user = create(:user, role: 0)

        allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

        visit '/login'

        expect(current_path).to eq('/profile')
        expect(page).to have_content("You are already logged in.")
      end
    end
  end

  describe 'As a Merchant Employee User' do
    it 'can login with valid credentials' do
      merchant_employee = create(:user, role: 1)

      visit '/'

      click_link('Login')

      expect(current_path).to eq('/login')

      fill_in :email, with: merchant_employee.email
      fill_in :password, with: 'password3'
      click_on('Submit')

      expect(current_path).to eq('/merchant/dashboard')
      expect(page).to have_content("Welcome back, #{merchant_employee.name} you are now logged in!")
      expect(page).to have_content("Hello, #{merchant_employee.name}! Welcome to your Merchant Dashboard!")
    end
  end

  describe 'As a Merchant Admin User' do
    it 'can login with valid credentials' do
      merchant_admin = create(:user, role: 2)

      visit '/'

      click_link('Login')

      expect(current_path).to eq('/login')

      fill_in :email, with: merchant_admin.email
      fill_in :password, with: 'password4'
      click_on('Submit')

      expect(current_path).to eq('/merchant/dashboard')
      expect(page).to have_content("Welcome back, #{merchant_admin.name} you are now logged in!")
      expect(page).to have_content("Hello, #{merchant_admin.name}! Welcome to your Merchant Dashboard!")
    end
  end

  describe 'As an Admin User' do
    it 'can login with valid credentials' do
      admin = create(:user, role: 3)

      visit '/'

      click_link('Login')

      expect(current_path).to eq('/login')

      fill_in :email, with: admin.email
      fill_in :password, with: 'password5'
      click_on('Submit')

      expect(current_path).to eq('/admin/dashboard')
      expect(page).to have_content("Welcome back, #{admin.name} you are now logged in!")
      expect(page).to have_content("Hello, #{admin.name}! Welcome to your Admin Dashboard!")
    end
  end
end

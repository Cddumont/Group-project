require "rails_helper"

feature "profile photo" do
  scenario "user uploads a profile photo" do
    visit root_path
    click_link "Sign Up"

    fill_in "First name", with: "bobby"
    fill_in "Last name", with: "johnson"
    fill_in "Username", with: "Shadowman"
    fill_in "Email", with: "ash@s-mart.com"
    fill_in "Password", with: "boomstick!3vilisd3ad"
    fill_in "Password confirmation", with: "boomstick!3vilisd3ad"
    attach_file :user_profile_photo, "#{Rails.root}/spec/support/images/Sonic.jpg"
    click_button "Sign up"

    expect(page).to have_content("Welcome! You have signed up successfully")
  end
end 
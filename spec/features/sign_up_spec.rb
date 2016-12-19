require 'rails_helper'

RSpec.describe "Sign Up" do
  scenario "Unauthenticated user completes form" do
    visit root_path
    click_link "Sign Up"
    fill_in "Email", with: "andrew@example.com"
    fill_in "Password", with: "password"
    fill_in "Password confirmation", with: "password"
    click_button "Sign Up"

    expect(current_path).to eq(links_path)
    expect(page).to have_content("andrew@example.com")
  end

  scenario "Unauthenticated user completes form with already registered email" do
    user = create :user, email: "andrew@example.com"
    visit root_path
    click_link "Sign Up"
    fill_in "Email", with: "andrew@example.com"
    fill_in "Password", with: "password"
    fill_in "Password confirmation", with: "password"
    click_button "Sign Up"

    expect(current_path).to eq(new_registration_path)
    expect(page).to have_content("Email has already been taken")
  end
  scenario "Unauthenticated user completes form" do
    visit root_path
    click_link "Sign Up"
    fill_in "Email", with: "andrew@example.com"
    fill_in "Password", with: "password"
    fill_in "Password confirmation", with: "password1"
    click_button "Sign Up"

    expect(current_path).to eq(new_registration_path)
    expect(page).to have_content("Password confirmation doesn't match Password")
  end
end

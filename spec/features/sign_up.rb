require 'rails_helper'

RSpec.feature "Sign up", type: feature do
  scenario "Unauthenticated user completes form" do
    visit root
    click_link "Sign Up"
    fill_in "Email", with: "andrew@example.com"
    fill_in "Password", with: "password"
    fill_in "Password confirmation", with: "password"
    click_button "Sign up"

    expect(current_path).to eq(links_path)
    expect(page).to have_content("andrew@example.com")
  end

  scenario "Unauthenticated user completes form with already registered email" do
    user = create :user, email: "andrew@example.com"
    visit root
    click_link "Sign Up"
    fill_in "Email", with: "andrew@example.com"
    fill_in "Password", with: "password"
    fill_in "Password confirmation", with: "password"
    click_button "Sign up"

    expect(current_path).to eq(registration_path)
    expect(page).to have_content("There is an account already associated with that email address.")
  end
  scenario "Unauthenticated user completes form" do
    visit root
    click_link "Sign Up"
    fill_in "Email", with: "andrew@example.com"
    fill_in "Password", with: "password"
    fill_in "Password confirmation", with: "password1"
    click_button "Sign up"

    expect(current_path).to eq(registration_path)
    expect(page).to have_content("Password and password confirmation do not match.")
  end
end

require 'rails_helper'

RSpec.describe "Sign up" do
  xscenario "" do
    user = create :user
    login(user)
    click_link "Sign Out"
  end
end

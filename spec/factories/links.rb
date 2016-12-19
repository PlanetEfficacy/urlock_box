FactoryGirl.define do
  factory :link do
    url "http://www.google.com"
    title "Best link ever"
    status 0
    user
  end
end

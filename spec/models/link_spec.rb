require 'rails_helper'

RSpec.describe Link, type: :model do
  it { should validate_presence_of(:url) }
  it { should validate_presence_of(:title) }
  it "requires a valid url" do
    link = Link.new(title: "My Link", url: "Hello World")
    expect(link.save).to eq(false)
  end
end

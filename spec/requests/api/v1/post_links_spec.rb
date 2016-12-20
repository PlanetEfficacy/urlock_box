require 'rails_helper'

describe "#post to /links", type: :request do
  it "returns the created link as json" do
    user = create :user
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    post "/api/v1/links", link: { title: "Great Link", url: "http://www.google.com"}
    link = JSON.parse(response.body)

    expect(response).to be_success
    expect(link).to be_instance_of(Hash)
    expect(link["id"]).to eq(Link.first.id)
    expect(link["title"]).to eq(Link.first.title)
    expect(link["url"]).to eq(Link.first.url)
    expect(link["status"]).to eq(Link.first.status)
  end

  it "returns an error if link is invalid" do
    user = create :user
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    post "/api/v1/links", link: { title: "Great Link", url: "hello world"}
    error = JSON.parse(response.body)

    expect(response).to have_http_status(:bad_request)
    expect(error["message"]).to eq("Url is not a valid URL")
  end
end

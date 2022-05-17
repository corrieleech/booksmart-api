require 'rails_helper'

RSpec.describe Club, type: :model do
  it "is the upvotes on the link" do
    user = User.new(name: "Abby Keating", email: "abby@gmail.com", password: "password", password_confirmation: "password", image: "https://pbs.twimg.com/profile_images/1455996520050872328/c86jxMqc_400x400.jpg", location: "Waukesha, WI", about: "I don’t join social media platforms often. But, when I do, it’s worth a read.", twitter: "@abbyreads")

    club = Club.new("isbn": "9780767930512", "name": "Feminist Book Club"
    # score = Score.new(link)

    # expect(score.upvotes).to eq 10
  end
end

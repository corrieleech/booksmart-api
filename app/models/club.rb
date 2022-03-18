class Club < ApplicationRecord
  has_many :memberships
  has_many :users, through: :memberships
  has_many :messages
  
  def book
    Rails.cache.fetch([self, :book], expires_in: 1.day) do
    api_key = Rails.application.credentials.rh_api
    response = HTTP.get("https://api.penguinrandomhouse.com/resources/v2/title/domains/PRH.US/titles/#{isbn}?&api_key=#{api_key}")
    book_data = response.parse(:json)["data"]["titles"][0]
    {
      title: book_data["title"],
      subtitle: book_data["subtitle"],
      author: book_data["author"],
      pages: book_data["pages"],
      cover_image: book_data["_links"][1]
    }
    end
  end

  def details
    api_key = Rails.application.credentials.rh_api
    response = HTTP.get("https://api.penguinrandomhouse.com/resources/v2/title/domains/PRH.US/titles/#{isbn}/content?api_key=#{api_key}")
    detailed_data = response.parse(:json)["data"]["content"]
    return {
      author_bio: detailed_data["rgauthbio"],
      disc_questions: detailed_data["rgdiscussion"],
      flap_copy: detailed_data["flapcopy"],
      positioning: detailed_data["positioning"]
    }
  end

end

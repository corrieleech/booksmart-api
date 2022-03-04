class Club < ApplicationRecord
  has_many :memberships
  has_many :users, through: :memberships
  has_many :messages
  
  def book_basic_info
    api = Rails.application.credentials.rh_api
    response = HTTP.get("https://api.penguinrandomhouse.com/resources/v2/title/domains/PRH.US/titles/#{isbn}?&api_key=#{api}")
    # return response.parse(:json)["data"]["titles"]
    book_data = response.parse(:json)["data"]["titles"][0]
    return {
      isbn: book_data["isbn"],
      title: book_data["title"],
      subtitle: book_data["subtitle"],
      author: book_data["author"],
      pages: book_data["pages"],
      cover_image: book_data["_links"][1]
    }
  end

  def discussion_questions
    api = Rails.application.credentials.rh_api
    response = HTTP.get("https://api.penguinrandomhouse.com/resources/v2/title/domains/PRH.US/titles/#{isbn}/content?api_key=#{api}")
    book_data = response.parse(:json)["data"]["content"]
    return {
      author_bio: book_data["rgauthbio"],
      disc_questions: book_data["rgdiscussion"],
      flap_copy: book_data["flapcopy"],
      positioning: book_data["positioning"]
    }
  end

end

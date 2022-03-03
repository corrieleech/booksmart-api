class Club < ApplicationRecord
  has_many :memberships
  has_many :users, through: :memberships
  has_many :messages

  #title, subtitle, author, pages, isbn
  
  
  def book_info
    api = Rails.application.credentials.rh_api
    response = HTTP.get("https://api.penguinrandomhouse.com/resources/v2/title/domains/PRH.US/works/#{work_id}/titles?showReadingGuides=true&api_key=#{api}")
    return response.parse(:json)["data"]["titles"]
  end

  def discussion_questions
    api = Rails.application.credentials.rh_api
    response = HTTP.get("https://api.penguinrandomhouse.com/resources/v2/title/domains/PRH.US/titles/#{isbn}/content?api_key=#{api}")
    book_data = response.parse(:json)["data"]["content"]
    return {
      author_bio: book_data["rgauthbio"],
      disc_questions: book_data["rgdiscussion"],
    }
  end

end

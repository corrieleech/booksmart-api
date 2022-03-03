class Club < ApplicationRecord
  has_many :memberships
  has_many :users, through: :memberships
  has_many :messages

  #title, subtitle, author, pages, isbn, cover image
  
  def book_basic_info
    api = Rails.application.credentials.rh_api
    response = HTTP.get("https://api.penguinrandomhouse.com/resources/v2/title/domains/PRH.US/titles/#{isbn}?&api_key=#{api}")
    return response.parse(:json)
  end

  def book_detailed_info
    api = Rails.application.credentials.rh_api
    response = HTTP.get("https://api.penguinrandomhouse.com/resources/v2/title/domains/PRH.US/works/#{work_id}/titles?showReadingGuides=true&api_key=#{api}")
    return response.parse(:json)["data"]["titles"]
  end

  #author bio, discussion questions, flap copy 
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

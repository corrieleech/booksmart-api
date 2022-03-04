class BooksController < ApplicationController

  #Index = List all results for a title search to find the work ID

  def index
    api = Rails.application.credentials.rh_api

    title_search = (params[:title_search]).gsub!(" ","+")
    
    response = HTTP.get("https://api.penguinrandomhouse.com/resources/v2/title/domains/PRH.US/search?q=#{params[:title_search]}&docType=work&api_key=#{api}")
    book_data = response.parse(:json)["data"]["results"]
    book_array = []
    book_data.each { |book| 
      if book["author"]
        author = book["author"][0].tr("0-9", "").tr("|", "")
      else
        author = "N/A"
      end
      possibility = { title: book["name"],
        author: author,
        work_id: book["key"]
      }
      book_array << possibility
      }
    render json: book_array
    # render json: response.parse(:json)["data"]["results"]
  end
  
  #Show = List work titles for a book that have reading guides
  def show
    api = Rails.application.credentials.rh_api
    response = HTTP.get("https://api.penguinrandomhouse.com/resources/v2/title/domains/PRH.US/works/#{params[:work_id]}/titles?showReadingGuides=true&api_key=#{api}")

    render json: response.parse(:json)["data"]
  end

  #Discussion = Lists discussion questions, aka, the gold mine.
  
  def discussion
    api = Rails.application.credentials.rh_api
    response = HTTP.get("https://api.penguinrandomhouse.com/resources/v2/title/domains/PRH.US/titles/#{params[:isbn]}/content?api_key=#{api}")

    render json: response.parse(:json)["data"]
  end

end
class BooksController < ApplicationController

  def index
    api = Rails.application.credentials.rh_api

    title_search = (params[:title_search]).gsub!(" ","+")
    
    response = HTTP.get("https://api.penguinrandomhouse.com/resources/v2/title/domains/PRH.US/search?q=#{params[:title_search]}&docType=work&api_key=#{api}")
    
    work_data = response.parse(:json)["data"]["results"]
    
    book_data = work_data.map do |work|
      title = HTTP.get("https://api.penguinrandomhouse.com/resources/v2/title/domains/PRH.US/works/#{work['key']}/titles?showReadingGuides=true&api_key=#{api}").parse(:json)
      title["data"]["titles"][0] if title["status"]
    end  
     
    render json: book_data.compact

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
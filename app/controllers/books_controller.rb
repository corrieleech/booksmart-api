class BooksController < ApplicationController

  # def index
  #   api_key = Rails.application.credentials.rh_api

  #   title_search = (params[:title_search]).gsub!(" ","+")
    
  #   response = HTTP.get("https://api.penguinrandomhouse.com/resources/v2/title/domains/PRH.US/search?q=#{params[:title_search]}&docType=work&api_key=#{api_key}")
    
  #   work_data = response.parse(:json)["data"]["results"]
    
  #   book_data = work_data.map do |work|
  #     title = HTTP.get("https://api.penguinrandomhouse.com/resources/v2/title/domains/PRH.US/works/#{work['key']}/titles?showReadingGuides=true&api_key=#{api_key}").parse(:json)
  #     title["data"]["titles"][0] if title["status"]
  #   end  
     
  #   render json: book_data.compact

  # end

  def index
    api_key = Rails.application.credentials.rh_api

    title_search = (params[:title_search]).gsub!(" ","+")

    response = HTTP.get("https://api.penguinrandomhouse.com/resources/v2/title/domains/PRH.US/search/views/search-display?q=#{params[:title_search]}&docType=work&api_key=#{api_key}")

    all_books = response.parse(:json)["data"]["results"]

    render json: all_books
  end

end
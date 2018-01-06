class SoupsController < ApplicationController

  def set_soups
  if request.put?
    Soup.all.each do |soup|
      soup.is_today = false
      Soup.save(soup)
    end
    available = params[:available].collect {|id| id.to_i} if params[:available]
    avalaible.each do |s|
      current = Soup.find(s.id)
      current.is_today = true
      Soup.save(current)
    end
end

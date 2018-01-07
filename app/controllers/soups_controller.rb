class SoupsController < ApplicationController

  def set_soups
    if request.put?
      params.permit!
      available = params[:soup][:available]
      available.keys.each do |key|
        soup = Soup.find(key.to_i)
        soup.updated_at = DateTime.now
        soup.is_today = available[key].eql?("yes")
        soup.save
      end
    end
    flash[:notice] = "You have updated the soups for the day!"
    redirect_to admin_dashboard_path
  end
end

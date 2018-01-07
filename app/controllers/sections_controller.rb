class SectionsController < ApplicationController
  before_action :set_section, only: [:show, :edit, :update, :destroy]

  # GET /sections
  # GET /sections.json
  def index
    @Soups = []
    puts Date.today.yday
    Soup.where(:is_today => true).each do |soup|
      puts soup.updated_at.yday
      if soup.updated_at.yday >= Date.today.yday
        puts soup
        @Soups.push(soup)
      end
    end
    @sections = Section.all
    @headings = Heading.all
    @images = CarouselImage.all.where(:visible => true)
  end

  # GET /sections/1
  # GET /sections/1.json
  def show
    @section = Section.find(params[:id])
    if !@section.visible
      redirect_to sections_url
    end
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_section
      @section = Section.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def section_params
      params.require(:section).permit(:name, :description, :heading_id)
    end
end

class SectionsController < ApplicationController
  before_action :set_section, only: %i[show edit update destroy]

  # GET /sections
  # GET /sections.json
  def index
    @Soups = []
    @Specials = []
    Soup.where(is_today: true).each do |soup|
      @Soups.push(soup) if soup.updated_at.yday >= Date.today.yday
    end
    Special.where(today: true).each do |special|
      @Specials.push(special) if special.updated_at.yday >= Date.today.yday
    end
    @sections = Section.all
    @headings = Heading.all
    @images = CarouselImage.all.where(visible: true)
  end

  # GET /sections/1
  # GET /sections/1.json
  def show
    redirect_to sections_url unless @section.visible
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_section
    @section = Section.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def section_params
    params.require(:section).permit(:name, :description, :heading_id, :image)
  end
end

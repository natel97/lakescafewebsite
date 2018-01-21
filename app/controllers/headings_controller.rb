class HeadingsController < ApplicationController
  before_action :set_heading, only: %i[show edit update destroy]

  # GET /headings
  # GET /headings.json
  def index
    @headings = Heading.all
  end

  # GET /headings/1
  # GET /headings/1.json
  def show; end

  def update_images
    params.permit!
    imgs = params[:carousel_image]
    imgs[:description].each do |img|
      puts imgs[:description][img]
      image = CarouselImage.find(img)
      image.description = imgs[:description][img]
      image.visible = imgs[:visible][img].eql?('yes')
      image.save
    end
    redirect_to '/admin'
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_heading
    @heading = Heading.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def heading_params
    params.require(:heading).permit(:name)
  end
end

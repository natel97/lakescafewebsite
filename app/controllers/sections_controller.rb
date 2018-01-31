class SectionsController < ApplicationController
  before_action :set_section, only: %i[show edit update destroy]

  # GET /sections
  # GET /sections.json
  def index
    @Soups = []
    @Specials = []
    get_access_token
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
    get_access_token
    @section = Section.find(params[:id])
    redirect_to sections_url unless @section.visible
  end

  private

  def get_access_token
    # Create a new API client & load the Google Drive API
    client = Google::APIClient.new(application_name: 'ppc-gd', application_version: PaperclipGoogleDrive::VERSION)
    drive = client.discovered_api('drive', 'v2')

    client.authorization.client_id = Variable.where(key: 'CLIENT_ID').first.value
    client.authorization.client_secret = Variable.where(key: 'CLIENT_SECRET').first.value
    client.authorization.scope = ['https://www.googleapis.com/auth/drive', 'https://www.googleapis.com/auth/userinfo.profile']
    client.authorization.redirect_uri = Variable.where(key: 'REDIRECT_URI').first.value
    client.authorization.refresh_token = Variable.where(key: 'REFRESH_TOKEN').first.value

    client.authorization.fetch_access_token!
    x = Variable.where(key: 'ACCESS_TOKEN').first
    if x.nil?
      x = Variable.new
      x.key = 'ACCESS_TOKEN'
    end
    x.value = client.authorization.access_token
    x.save
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

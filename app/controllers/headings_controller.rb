class HeadingsController < ApplicationController
  before_action :set_heading, only: [:show, :edit, :update, :destroy]

  # GET /headings
  # GET /headings.json
  def index
    @headings = Heading.all
  end

  # GET /headings/1
  # GET /headings/1.json
  def show
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

class SubItemsController < ApplicationController
  before_action :set_sub_item, only: [:show, :edit, :update, :destroy]

  # GET /sub_items
  # GET /sub_items.json
  def index
    @sub_items = SubItem.all
  end

  # GET /sub_items/1
  # GET /sub_items/1.json
  def show
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_sub_item
      @sub_item = SubItem.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def sub_item_params
      params.require(:sub_item).permit(:name, :description, :price, :item_id)
    end
end

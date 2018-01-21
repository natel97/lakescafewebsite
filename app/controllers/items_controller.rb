class ItemsController < ApplicationController
  before_action :set_item, only: %i[show edit update destroy]

  # GET /items
  # GET /items.json
  def index
    @items = Item.all
  end

  # GET /items/1
  # GET /items/1.json
  def show; end

  def update_menu
    params.permit!
    puts params
    heading_names = params[:heading_names]
    section_names = params[:section_names]
    section_descriptions = params[:section_descriptions]
    item_names = params[:item_names]
    item_description = params[:item_description]
    item_price = params[:item_price]
    sub_item_names = params[:sub_item_names]
    sub_item_description = params[:sub_item_description]
    sub_item_price = params[:sub_item_price]

    heading_names.each do |name|
      head = Heading.find(name)
      head.name = heading_names[name]
      head.save
    end

    section_names.each do |section|
      sect = Section.find(section)
      sect.name = section_names[section]
      sect.description = section_descriptions[section]
      sect.save
    end

    item_names.each do |item|
      i = Item.find(item)
      i.name = item_names[item]
      i.description = item_description[item]
      i.price = item_price[item]
      i.save
    end

    sub_item_names.each do |sub_item|
      si = SubItem.find(sub_item)
      si.name = sub_item_names[sub_item]
      si.description = sub_item_description[sub_item]
      si.price = sub_item_price[sub_item]
      si.save
    end

    flash[:notice] = 'You have updated the menu!'
    redirect_to '/admin/dashboard'
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_item
    @item = Item.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def item_params
    params.require(:item).permit(:name, :description, :price, :section_id)
  end
end

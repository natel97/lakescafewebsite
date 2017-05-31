json.extract! sub_item, :id, :name, :description, :price, :item_id, :created_at, :updated_at
json.url sub_item_url(sub_item, format: :json)

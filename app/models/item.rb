class Item < ApplicationRecord
  belongs_to :section
  has_many :sub_items
end

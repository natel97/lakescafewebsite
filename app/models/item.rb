class Item < ApplicationRecord
  belongs_to :section
  has_many :subitems
end

class Section < ApplicationRecord
  belongs_to :heading
  has_many :items
end

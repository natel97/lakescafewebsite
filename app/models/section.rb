class Section < ApplicationRecord
  belongs_to :heading
  has_many :items
  has_attached_file :image, 
    default_url: "/hot-beef.jpg"
  validates_attachment :image, presence: true
  do_not_validate_attachment_file_type :image
end

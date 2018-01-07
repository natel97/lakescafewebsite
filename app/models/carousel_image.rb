class CarouselImage < ApplicationRecord

  do_not_validate_attachment_file_type :image
  has_attached_file :image,
    :storage => :google_drive,
    :google_drive_credentials => "#{Rails.root}/config/google_drive.yml",
    :google_drive_options => {
    :public_folder_id => "1rwz3Znw3nWR2CFNP9Oli0d0gJ8i58_8_"
  }

  
end

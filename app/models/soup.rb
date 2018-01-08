class Soup < ApplicationRecord
  do_not_validate_attachment_file_type :image
  has_attached_file :image,
                    storage: :google_drive,
                    google_drive_credentials: {
                      'client_id' => Variable.where(key: 'CLIENT_ID').first.value,
                      'client_secret' => Variable.where(key: 'CLIENT_SECRET').first.value,
                      'access_token' => Variable.where(key: 'ACCESS_TOKEN').first.value,
                      'refresh_token' => Variable.where(key: 'REFRESH_TOKEN').first.value
                    }, google_drive_options: {
                      public_folder_id: '1rwz3Znw3nWR2CFNP9Oli0d0gJ8i58_8_'
                    }
end

require 'paperclip/media_type_spoof_detector'
# Create a new API client & load the Google Drive API
client = Google::APIClient.new(application_name: 'ppc-gd', application_version: PaperclipGoogleDrive::VERSION)
drive = client.discovered_api('drive', 'v2')

client.authorization.client_id = Variable.where(key: 'CLIENT_ID').first.value
client.authorization.client_secret = Variable.where(key: 'CLIENT_SECRET').first.value
client.authorization.scope = ['https://www.googleapis.com/auth/drive', 'https://www.googleapis.com/auth/userinfo.profile']
client.authorization.redirect_uri = Variable.where(key: 'REDIRECT_URI').first.value
client.authorization.refresh_token = Variable.where(key: 'REFRESH_TOKEN').first.value

client.authorization.fetch_access_token!
x = Variable.where(key: 'ACCESS_TOKEN').first
if x.nil?
  x = Variable.new
  x.key = 'ACCESS_TOKEN'
end
x.value = client.authorization.access_token
x.save
module Paperclip
  class MediaTypeSpoofDetector
    def spoofed?
      false
    end
  end
end

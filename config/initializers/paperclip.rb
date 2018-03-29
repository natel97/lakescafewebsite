require 'paperclip/media_type_spoof_detector'
require 'open-uri'
# Create a new API client & load the Google Drive API
client = Google::APIClient.new(application_name: 'ppc-gd', application_version: PaperclipGoogleDrive::VERSION)
drive = client.discovered_api('drive', 'v2')

def getFile (output, input, client)
  unless (File.file?(output))
    unless(input == "No picture")
      client.authorization.fetch_access_token!
      puts output
      File.open(output, "wb") do |local|
        open(input) do |remote|
          local.write(remote.read)
        end
      end
    end
  end
end

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
Section.where.not(:image_file_name => nil).each do |section|
  getFile Dir.pwd + "/public/section--" + section.id.to_s + "." + section.image_file_name.split(".").last, section.image.url(:original), client
end
CarouselImage.where.not(:image_file_name => nil).each do |image|
  getFile Dir.pwd + "/public/carousel--" + image.id.to_s + "." + image.image_file_name.split(".").last, image.image.url(:original), client
end
Soup.where.not(:image_file_name => nil).each do |soup|
  getFile Dir.pwd + "/public/soup--" + soup.id.to_s + "." +  soup.image_file_name.split(".").last, soup.image.url(:original), client
end

module Paperclip
  class MediaTypeSpoofDetector
    def spoofed?
      false
    end
  end
end

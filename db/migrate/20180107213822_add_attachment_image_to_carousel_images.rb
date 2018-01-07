class AddAttachmentImageToCarouselImages < ActiveRecord::Migration[5.1]
  def self.up
    change_table :carousel_images do |t|
      t.attachment :image
    end
  end

  def self.down
    remove_attachment :carousel_images, :image
  end
end

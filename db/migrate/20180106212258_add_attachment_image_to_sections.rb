class AddAttachmentImageToSections < ActiveRecord::Migration[5.1]
  def self.up
    change_table :sections do |t|
      t.attachment :image
    end
  end

  def self.down
    remove_attachment :sections, :image
  end
end

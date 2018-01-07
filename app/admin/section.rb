ActiveAdmin.register Section do
# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
#
permit_params :heading_id, :name, :description, :imageURL, :visible, :image_caption, :image
#
# or
#
# permit_params do
#   permitted = [:permitted, :attributes]
#   permitted << :other if params[:action] == 'create' && current_user.admin?
#   permitted
# end

form do |f|
  f.inputs "Section Details" do
    f.input :heading
    f.input :name
    f.input :description
    f.input :imageURL
    f.input :visible
    f.input :image_caption
    f.input :image, :required => true, :as => :file
  end
  f.actions
 end

show do |ad|
  attributes_table do
    row :name
    row :image do
      image_tag(ad.image.url(:original), :style => "width: 640px; height: 480px;")
    end
  end
 end
end

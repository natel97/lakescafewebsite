ActiveAdmin.register CarouselImage do
# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
#
 permit_params :image_url, :description, :visible, :image
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
    f.input :image_url
    f.input :description
    f.input :visible
    f.input :image, :required => true, :as => :file
  end
  f.actions
 end

show do |ad|
  attributes_table do
    row :description
    row :visible
    row :image do
      image_tag(ad.image.url(:original), :style => "width: 640px; height: 480px;")
    end
  end
 end

end

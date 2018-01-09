ActiveAdmin.register Soup do
# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
#
permit_params :name, :image_url, :is_today, :image
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
    f.input :name
    f.input :image_url
    f.input :is_today
    f.input :image, :as => :file
  end
  f.actions
 end

show do |ad|
  attributes_table do
    row :name
    row :is_today
    row :image do
      image_tag(ad.image.url(:original), :style => "width: 640px; height: 480px;")
    end
  end
 end

end
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
    f.inputs 'Section Details' do
      f.input :description
      f.input :visible
      f.input :image, required: true, as: :file
    end
    f.actions
  end

  show do |ad|
    unless ad.image.url(:original) == 'No picture'
      File.open(Dir.pwd + '\assets\images\carousel--' + ad.id.to_s + '.' + ad.image_file_name.split('.').last, 'wb') do |local|
        open(ad.image.url(:original)) do |remote|
          local.write(remote.read)
        end
      end
    end
    attributes_table do
      row :description
      row :visible
      row :image do
        image_tag("carousel--" + ad.id.to_s + "." + ad.image_file_name.split('.').last, style: 'width: 640px; height: 480px;')
      end
    end
  end
end

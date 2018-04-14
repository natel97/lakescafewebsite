ActiveAdmin.register Section do
  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  permit_params :heading_id, :name, :description, :visible, :image_caption, :image
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
      f.input :heading
      f.input :name
      f.input :description
      f.input :visible
      f.input :image_caption
      f.input :image, required: true, as: :file
    end
    f.actions
  end

  show do |ad|
    unless ad.image.url(:original) == 'No picture'
    File.open(Dir.pwd + '/public/section--' + ad.id.to_s + '.' +  ad.image_file_name.split('.').last, 'wb') do |local|
        open(ad.image.url(:original)) do |remote|
          local.write(remote.read)
        end
      end
    end
    attributes_table do
      row :name
      row :image do
        image_tag('section--' + ad.id.to_s + '.' + ad.image_file_name.split('.').last, style: 'width: 640px; height: 480px;')
      end
    end
  end
end

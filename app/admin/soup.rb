ActiveAdmin.register Soup do
  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  permit_params :name, :is_today, :image
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
      f.input :name
      f.input :is_today
      f.input :image, as: :file
      f.label 'Please resize photos to 640px480px to keep load times low!'
    end
    f.actions
  end

  show do |ad|
    attributes_table do
      unless ad.image.url(:original) == 'No picture'
        File.open(Dir.pwd + '/public/' + ad.id.to_s + '.' +  ad.image_file_name.split('.').last, 'wb') do |local|
          open(ad.image.url(:original)) do |remote|
            local.write(remote.read)
          end
        end
      end  
      row :name
      row :is_today
      row :image do
        image_tag('/soup--' + ad.id.to_s + '.' + ad.image_file_name.split('.').last, style: 'width: 640px; height: 480px;')
      end
    end
  end
end

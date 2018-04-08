ActiveAdmin.register_page 'Dashboard' do
  menu priority: 1, label: proc { I18n.t('active_admin.dashboard') }

  content title: proc { I18n.t('active_admin.dashboard') } do
    div do
      flash[:message]
    end
    #   div class: "blank_slate_container", id: "dashboard_default_message" do
    #     span class: "blank_slate" do
    #       span I18n.t("active_admin.dashboard_welcome.welcome")
    #       small I18n.t("active_admin.dashboard_welcome.call_to_action")
    #     end
    #   end

    # Here is an example of a simple dashboard with columns and panels.
    #
    # columns do
    #   column do
    #     panel "Recent Posts" do
    #       ul do
    #         Post.recent(5).map do |post|
    #           li link_to(post.title, admin_post_path(post))
    #         end
    #       end
    #     end
    #   end
    unless Variable.where(key: 'ACTIVATION_URL').first.nil?
      columns do
        column do
          panel 'Activate Google Drive!' do
            section do
              div do
                a href: Variable.where(key: 'ACTIVATION_URL').first.value.to_s, target: '_blank' do
                  span 'If the above does not display, click here'
                end
              end
            end
          end
        end
        column do
          panel 'Paste code here!' do
            section do
              form_for :variable, url: '/admin/alter-variables', html: { method: :put } do |f|
                table_for Variable.where(key: 'AUTHORIZATION_CODE') do |_variable_fields|
                  fields_for 'variables[variable[]]', _variable_fields do |_var|
                    _variable_fields.column('Key') { |_var| f.label _var.key, id: 'key[' + _var.id.to_s + ']', name: 'key[' + _var.id.to_s + ']' }
                    _variable_fields.column('Value') { |_var| f.input :value, value: _var.value, id: 'value[' + _var.id.to_s + ']', name: 'value[' + _var.id.to_s + ']' }
                  end
                end
                f.submit
              end
            end
          end
        end
      end
    end
    columns do
      column do
        panel 'Soups' do
          section do
            form_for :soup, url: '/admin/set-soup', html: { method: :put } do |f|
              table_for Soup.all do |s|
                fields_for 'soups[soup[]]', s do |_soup_fields|
                  s.column('Soup') { |soup| link_to(soup.name, admin_soup_path(soup)) }
                  s.column('Available') { |soup| f.check_box('available[' + soup.id.to_s + ']', { checked: soup.is_today }, 'yes', 'no') }
                end
              end
              f.submit
            end
          end
        end
      end
      column do
        panel 'Specials' do
          section do
            form_for :specials, url: '/admin/set-specials', html: { method: :put } do |f|
              table_for Special.all do |table|
                fields_for 'specials[]', table do |_field|
                  table.column('Name') { |var| link_to(var.name, admin_special_path(var)) }
                  table.column('Type') { |var| status_tag var.breakfast ? 'Breakfast' : 'Lunch', class: var.breakfast ? 'orange' : 'green' }
                  table.column('Today\'s Special') { |var| f.check_box :today, checked: var.today, id: 'today[' + var.id.to_s + ']', name: 'today[' + var.id.to_s + ']' }
                end
              end
              f.submit('Save Specials!')
            end
          end
        end
      end
      column do
        panel 'Variables', id: 'variables-button', class: 'clickable', onClick: 'openClose()' do
          section id: 'variables', class: 'hidden-content' do
            form_for :variable, url: '/admin/alter-variables', html: { method: :put } do |f|
              table_for Variable.all do |_variable_fields|
                fields_for 'variables[variable[]]', _variable_fields do |_var|
                  _variable_fields.column('Key') { |_var| f.label _var.key, id: 'key[' + _var.id.to_s + ']', name: 'key[' + _var.id.to_s + ']' }
                  _variable_fields.column('Value') { |_var| f.input :value, value: _var.value, id: 'value[' + _var.id.to_s + ']', name: 'value[' + _var.id.to_s + ']' }
                end
              end
              columns do
                column do
                  f.submit('Relink Google Drive!', name: 'google_drive')
                end
                column do
                  f.submit
                end
              end
            end
          end
        end
      end
    end
    columns do
      column do
        panel 'Common Actions' do
          columns do
            column do
              link_to 'New Heading', '/admin/headings/new'
            end
            column do
              link_to 'New Section', '/admin/sections/new'
            end
            column do
              link_to 'New Item', '/admin/items/new'
            end
            column do
              link_to 'New Sub Item', '/admin/sub_items/new'
            end
            column do
              link_to 'New Soup', '/admin/soups/new'
            end
            column do
              link_to 'New Carousel Image', '/admin/carousel_images/new'
            end
            column do
              link_to 'New Special', '/admin/specials/new'
            end
          end
        end
      end
      column do
        panel 'Questions?' do
          div do
            br
            text_node %(
            <p>Feel free to email me <a href="mailto:nate.lubitz@gmail.com">here</a>.</p>
            ).html_safe
          end
        end
      end
    end
    columns do
      column do
        panel 'Carousel Images' do
          form_for :carousel_image, url: '/admin/update-images', html: { method: :put } do |f|
            table_for CarouselImage.all do |table|
              table.column('Image') { |img| image_tag (img.image_file_name.nil? ? '/lakesCafeLogo.png' : '/section--' + img.id.to_s + '.' + img.image_file_name.split('.').last), size: '64x48' }
              table.column('Description') { |_img| f.text_field('description[' + _img.id.to_s + ']', value: _img.description) }
              table.column('Visible') { |_img| f.check_box('visible[' + _img.id.to_s + ']', { checked: _img.visible }, 'yes', 'no') }
            end
            f.submit('Update Carousel Images')
          end
        end
      end
    end
  end
end

#   column do
#     panel "Info" do
#       para "Welcome to ActiveAdmin."
#     end
#   end
# end
# content

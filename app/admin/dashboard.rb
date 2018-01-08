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
                iframe src: Variable.where(key: 'ACTIVATION_URL').first.value do
                  a href: Variable.where(key: 'ACTIVATION_URL').first.value.to_s, target: '_blank' do
                    span 'Click here to activate, paste your value in the AUTHORIZATION_CODE key'
                  end
                end
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
        panel 'Variables' do
          section do
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
  end
end

#   column do
#     panel "Info" do
#       para "Welcome to ActiveAdmin."
#     end
#   end
# end
# content

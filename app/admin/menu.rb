ActiveAdmin.register_page 'Menu' do
  content do
    panel 'Edit Menu' do
      form_for :heading, url: '/admin/update-menu', html: { method: :put } do |_form|
        table_for Heading.all do |_heading|
          fields_for 'headings[]', _heading do |_head_f|
            _heading.column('Heading') { |_var| _form.text_field :name, value: _var.name, id: 'heading_names[' + _var.id.to_s + ']', name: 'heading_names[' + _var.id.to_s + ']' }
            _heading.column('Sections') do |_heading_attr|
              unless _heading_attr.sections.empty?
                table_for _heading_attr.sections do |_section|
                  fields_for 'sections[]', _section do |_sect_f|
                    _section.column('Section') { |_a| _form.text_field :name, value: _a.name, id: 'section_names[' + _a.id.to_s + ']', name: 'section_names[' + _a.id.to_s + ']' }
                    _section.column('Description') { |_a| _form.text_area :description, value: _a.description, id: 'section_descriptions[' + _a.id.to_s + ']', name: 'section_descriptions[' + _a.id.to_s + ']' }
                    _section.column('Items') do |_section_attr|
                      unless _section_attr.items.empty?
                        table_for _section_attr.items do |t|
                          fields_for 'items[]', t do |_item_f|
                            t.column('Name') { |_a| _form.text_field :name, value: _a.name, id: 'item_names[' + _a.id.to_s + ']', name: 'item_names[' + _a.id.to_s + ']' }
                            t.column('Description') { |_a| _form.text_area :description, value: _a.description, id: 'item_description[' + _a.id.to_s + ']', name: 'item_description[' + _a.id.to_s + ']' }
                            t.column('Price') { |_a| _form.number_field :price, value: _a.price, id: 'item_price[' + _a.id.to_s + ']', name: 'item_price[' + _a.id.to_s + ']', in: 0.00..100.00, step: 0.01 }
                            t.column('Sub-Items') do |_item_attr|
                              unless _item_attr.sub_items.empty?
                                table_for _item_attr.sub_items do |_st|
                                  fields_for 'sub_items', _st do |_si_f|
                                    _st.column('Name') { |_a| _form.text_field :name, value: _a.name, id: 'sub_item_names[' + _a.id.to_s + ']', name: 'sub_item_names[' + _a.id.to_s + ']' }
                                    _st.column('Description') { |_a| _form.text_area :description, value: _a.description, id: 'sub_item_description[' + _a.id.to_s + ']', name: 'sub_item_description[' + _a.id.to_s + ']' }
                                    _st.column('Price') { |_a| _form.number_field :price, value: _a.price, id: 'sub_item_price[' + _a.id.to_s + ']', name: 'sub_item_price[' + _a.id.to_s + ']', in: 0.00..100.00, step: 0.01 }
                                  end
                                end
                                end
                            end
                          end
                        end
                        end
                    end
                  end
                end
                end
            end
          end
        end
        _form.submit 'Update menu'
      end
    end
  end
end
